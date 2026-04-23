using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using WebApplication1;

namespace WebApplication1
{
    public partial class ApproveUnpaidLeaves : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null) Response.Redirect("~/Login.aspx");
                LoadUnpaidLeaves();
            }
        }

        private void LoadUnpaidLeaves()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT l.request_ID, e.first_name + ' ' + e.last_name as EmployeeName, 
                           e.dept_name, l.start_date, l.end_date, 
                           DATEDIFF(day, l.start_date, l.end_date) + 1 as Days,
                           l.final_approval_status
                    FROM Leave l
                    INNER JOIN Unpaid_Leave ul ON l.request_ID = ul.request_ID
                    INNER JOIN Employee e ON ul.Emp_ID = e.employee_id
                    WHERE l.final_approval_status = 'Pending'";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvUnpaidLeaves.DataSource = dt;
                    gvUnpaidLeaves.DataBind();
                }
            }
        }

        protected void gvUnpaidLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int requestID = Convert.ToInt32(e.CommandArgument);
                int upperboardID = Convert.ToInt32(Session["EmployeeID"]);
                string status = e.CommandName == "Approve" ? "Approved" : "Rejected";

                try
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = @"
                            UPDATE Employee_Approve_Leave 
                            SET status = @status 
                            WHERE leave_id = @requestID AND Emp1_ID = @upperboardID;
                            
                            UPDATE Leave 
                            SET final_approval_status = @status 
                            WHERE request_ID = @requestID";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@requestID", requestID);
                            command.Parameters.AddWithValue("@upperboardID", upperboardID);
                            command.Parameters.AddWithValue("@status", status);

                            connection.Open();
                            command.ExecuteNonQuery();

                            ShowMessage($"Leave request {status.ToLower()} successfully!", "success");
                            LoadUnpaidLeaves();
                        }
                    }
                }
                catch (Exception ex) { ShowMessage("Error: " + ex.Message, "error"); }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Redirect to EmpDashboard.aspx with employee ID
            string redirectUrl = "EmpDashboard.aspx";

            if (Session["EmployeeID"] != null)
            {
                redirectUrl += "?empId=" + Session["EmployeeID"].ToString();
            }
            else if (Request.QueryString["empId"] != null)
            {
                redirectUrl += "?empId=" + Request.QueryString["empId"];
            }

            Response.Redirect(redirectUrl);
        }

        // Add this method to fix the compilation error
        protected string GetStatusClass(string status)
        {
            if (string.IsNullOrEmpty(status))
                return "status-badge";

            switch (status.ToLower())
            {
                case "pending":
                    return "status-badge status-pending";
                case "approved":
                    return "status-badge status-approved";
                case "rejected":
                    return "status-badge status-rejected";
                default:
                    return "status-badge";
            }
        }

        private void ShowMessage(string message, string type)
        {
            // For the new design, we need to update this method
            lblMessage.Text = message;

            // Set appropriate CSS class based on message type
            if (type == "success")
            {
                lblMessage.CssClass = "message-box success-message";
            }
            else if (type == "error")
            {
                lblMessage.CssClass = "message-box error-message";
            }
            else
            {
                lblMessage.CssClass = "message-box info-message";
            }

            // Ensure the message is visible
            lblMessage.Visible = true;

            // Hide the old panel if it exists
            if (pnlMessage != null)
                pnlMessage.Visible = false;
        }
    }
}