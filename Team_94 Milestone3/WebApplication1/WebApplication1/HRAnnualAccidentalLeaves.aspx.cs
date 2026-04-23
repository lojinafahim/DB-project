using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class HRAnnualAccidentalLeaves : System.Web.UI.Page
    {
        private string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HR_ID"] == null)
                Response.Redirect("HRLogin.aspx");

            if (!IsPostBack)
            {
                lblWelcome.Text = $"Logged in HR ID: {Session["HR_ID"]}";
                BindAnnualAccidental();
            }

            Page.MaintainScrollPositionOnPostBack = true;
        }

        private void BindAnnualAccidental()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string q = @"
                SELECT l.request_ID, COALESCE(a.emp_ID, ac.emp_ID) AS emp_ID,
                       CASE WHEN a.request_ID IS NOT NULL THEN 'Annual' ELSE 'Accidental' END AS leave_type,
                       l.start_date, l.end_date, l.num_days
                FROM dbo.Leave l
                LEFT JOIN dbo.Annual_Leave a ON a.request_ID = l.request_ID
                LEFT JOIN dbo.Accidental_Leave ac ON ac.request_ID = l.request_ID
                WHERE l.final_approval_status = 'Pending'
                  AND (a.request_ID IS NOT NULL OR ac.request_ID IS NOT NULL);";

                SqlDataAdapter da = new SqlDataAdapter(q, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlNoData.Visible = true;
                    gvAnnualAcc.Visible = false;
                }
                else
                {
                    pnlNoData.Visible = false;
                    gvAnnualAcc.Visible = true;
                    gvAnnualAcc.DataSource = dt;
                    gvAnnualAcc.DataBind();
                }
            }
        }

        protected void gvAnnualAcc_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int requestId = Convert.ToInt32(gvAnnualAcc.DataKeys[rowIndex].Value);
                int hrId = Convert.ToInt32(Session["HR_ID"]);

                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    using (SqlCommand cmd = new SqlCommand("HR_approval_an_acc", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@request_ID", requestId);
                        cmd.Parameters.AddWithValue("@HR_ID", hrId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    lblStatus.Text = $"{e.CommandName} request {requestId} successfully.";
                    lblStatus.CssClass = "message-label success-message";
                    BindAnnualAccidental();
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