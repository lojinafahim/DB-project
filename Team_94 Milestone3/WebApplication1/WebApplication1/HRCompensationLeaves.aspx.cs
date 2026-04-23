using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class HRCompensationLeaves : System.Web.UI.Page
    {
        private string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HR_ID"] == null)
                Response.Redirect("HRLogin.aspx");

            if (!IsPostBack)
            {
                lblWelcome.Text = $"Logged in HR ID: {Session["HR_ID"]}";
                BindCompensation();
            }

            Page.MaintainScrollPositionOnPostBack = true;
        }

        private void BindCompensation()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string q = @"
                SELECT l.request_ID, c.emp_ID, c.date_of_original_workday, 
                       l.start_date, l.end_date, l.num_days
                FROM dbo.Leave l
                INNER JOIN dbo.Compensation_Leave c ON c.request_ID = l.request_ID
                WHERE l.final_approval_status = 'Pending';";

                SqlDataAdapter da = new SqlDataAdapter(q, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlNoData.Visible = true;
                    gvComp.Visible = false;
                }
                else
                {
                    pnlNoData.Visible = false;
                    gvComp.Visible = true;
                    gvComp.DataSource = dt;
                    gvComp.DataBind();
                }
            }
        }

        protected void gvComp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int requestId = Convert.ToInt32(gvComp.DataKeys[rowIndex].Value);
                int hrId = Convert.ToInt32(Session["HR_ID"]);

                string status = e.CommandName == "Approve" ? "Approved" : "Rejected";

                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();

                        using (SqlCommand cmd = new SqlCommand(
                            "IF EXISTS (SELECT 1 FROM Employee_Approve_Leave WHERE leave_ID = @request_ID AND Emp1_ID = @HR_ID) " +
                            "UPDATE Employee_Approve_Leave SET status = @status WHERE leave_ID = @request_ID AND Emp1_ID = @HR_ID " +
                            "ELSE " +
                            "INSERT INTO Employee_Approve_Leave (Emp1_ID, leave_ID, status) VALUES (@HR_ID, @request_ID, @status)", conn))
                        {
                            cmd.Parameters.AddWithValue("@status", status);
                            cmd.Parameters.AddWithValue("@request_ID", requestId);
                            cmd.Parameters.AddWithValue("@HR_ID", hrId);
                            cmd.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd = new SqlCommand(
                            "UPDATE Leave SET final_approval_status = @status WHERE request_ID = @request_ID", conn))
                        {
                            cmd.Parameters.AddWithValue("@status", status);
                            cmd.Parameters.AddWithValue("@request_ID", requestId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblStatus.Text = $"{e.CommandName} compensation request {requestId} successfully.";
                    lblStatus.CssClass = "message-label success-message";
                    BindCompensation();
                }
                catch (Exception ex)
                {
                    lblStatus.Text = $"Error processing request: {ex.Message}";
                    lblStatus.CssClass = "message-label error-message";
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
    }
}