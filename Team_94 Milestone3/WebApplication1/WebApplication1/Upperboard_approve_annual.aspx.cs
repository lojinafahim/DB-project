using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ApproveAnnualLeaves : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null) Response.Redirect("~/Login.aspx");
                LoadAnnualLeaves();
            }
        }

        private void LoadAnnualLeaves()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT l.request_ID, e1.first_name + ' ' + e1.last_name as EmployeeName, 
                           e1.dept_name, l.start_date, l.end_date, 
                           DATEDIFF(day, l.start_date, l.end_date) + 1 as Days,
                           e2.first_name + ' ' + e2.last_name as ReplacementName,
                           al.replacement_emp, l.final_approval_status
                    FROM Leave l
                    INNER JOIN Annual_Leave al ON l.request_ID = al.request_ID
                    INNER JOIN Employee e1 ON al.emp_ID = e1.employee_id
                    LEFT JOIN Employee e2 ON al.replacement_emp = e2.employee_id
                    WHERE l.final_approval_status = 'Pending'";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvAnnualLeaves.DataSource = dt;
                    gvAnnualLeaves.DataBind();

                    // Show empty state message if no data
                    if (dt.Rows.Count == 0)
                    {
                        gvAnnualLeaves.ShowHeaderWhenEmpty = true;
                        gvAnnualLeaves.EmptyDataText = "<div class='empty-state'><div class='empty-state-icon'>📋</div><div class='empty-state-text'>No annual leave requests pending approval.</div></div>";
                    }
                }
            }
        }

        protected void gvAnnualLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int requestID = Convert.ToInt32(args[0]);
                int replacementID = 0;

                // Handle null/empty replacement ID
                if (args.Length > 1 && !string.IsNullOrEmpty(args[1]))
                {
                    int.TryParse(args[1], out replacementID);
                }

                int upperboardID = Convert.ToInt32(Session["EmployeeID"]);

                try
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    using (SqlCommand command = new SqlCommand("Upperboard_approve_annual", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@request_ID", requestID);
                        command.Parameters.AddWithValue("@Upperboard_ID", upperboardID);
                        command.Parameters.AddWithValue("@replacement_ID", replacementID);

                        connection.Open();
                        command.ExecuteNonQuery();

                        ShowMessage("✅ Annual leave approved successfully!", "success");
                        LoadAnnualLeaves();
                    }
                }
                catch (SqlException sqlEx)
                {
                    ShowMessage("❌ Database error: " + sqlEx.Message, "error");
                }
                catch (Exception ex)
                {
                    ShowMessage("❌ Error: " + ex.Message, "error");
                }
            }
            else if (e.CommandName == "Reject")
            {
                int requestID = Convert.ToInt32(e.CommandArgument);
                int upperboardID = Convert.ToInt32(Session["EmployeeID"]);

                try
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = @"
                            UPDATE Employee_Approve_Leave 
                            SET status = 'Rejected' 
                            WHERE leave_ID = @requestID AND Emp1_ID = @upperboardID;
                            
                            UPDATE Leave 
                            SET final_approval_status = 'Rejected' 
                            WHERE request_ID = @requestID";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@requestID", requestID);
                            command.Parameters.AddWithValue("@upperboardID", upperboardID);

                            connection.Open();
                            command.ExecuteNonQuery();

                            ShowMessage("✅ Annual leave rejected successfully!", "success");
                            LoadAnnualLeaves();
                        }
                    }
                }
                catch (SqlException sqlEx)
                {
                    ShowMessage("❌ Database error: " + sqlEx.Message, "error");
                }
                catch (Exception ex)
                {
                    ShowMessage("❌ Error: " + ex.Message, "error");
                }
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

        private void ShowMessage(string message, string type)
        {
            // Set the message text
            lblMessage.Text = message;

            // Clear and set CSS classes
            lblMessage.CssClass = "message-box";

            // Add appropriate message class
            switch (type.ToLower())
            {
                case "success":
                    lblMessage.CssClass += " success-message";
                    break;
                case "error":
                    lblMessage.CssClass += " error-message";
                    break;
                default:
                    lblMessage.CssClass += " info-message";
                    break;
            }
        }

        protected string GetStatusClass(string status)
        {
            switch (status?.ToLower())
            {
                case "pending":
                    return "status-badge status-pending";
                case "approved":
                    return "status-badge status-approved";
                case "rejected":
                    return "status-badge status-rejected";
                default:
                    return "status-badge status-pending";
            }
        }
    }
}