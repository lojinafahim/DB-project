using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Submit_unpaid : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null) Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate required fields
                if (string.IsNullOrEmpty(txtStartDate.Text) ||
                    string.IsNullOrEmpty(txtEndDate.Text) ||
                    string.IsNullOrEmpty(txtDocumentDescription.Text) ||
                    string.IsNullOrEmpty(txtFileName.Text))
                {
                    ShowMessage("❌ Please fill in all required fields.", "error");
                    return;
                }

                // Parse dates
                DateTime startDate = DateTime.Parse(txtStartDate.Text);
                DateTime endDate = DateTime.Parse(txtEndDate.Text);

                // Validate date range
                if (endDate < startDate)
                {
                    ShowMessage("❌ End date must be after start date.", "error");
                    return;
                }

                // Calculate days difference
                TimeSpan duration = endDate - startDate;
                int totalDays = duration.Days + 1; // Include both start and end dates

                // Check 30-day limit for unpaid leave
                if (totalDays > 30)
                {
                    ShowMessage($"❌ Unpaid leave cannot exceed 30 days. You requested {totalDays} days.", "error");
                    return;
                }

                int employeeID = Convert.ToInt32(Session["EmployeeID"]);
                string documentDescription = txtDocumentDescription.Text;
                string fileName = txtFileName.Text;

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = new SqlCommand("Submit_Unpaid_Leave", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@emp_ID", employeeID);
                    command.Parameters.AddWithValue("@start_date", startDate);
                    command.Parameters.AddWithValue("@end_date", endDate);
                    command.Parameters.AddWithValue("@document_desc", documentDescription);
                    command.Parameters.AddWithValue("@file_name", fileName);

                    connection.Open();
                    command.ExecuteNonQuery();

                    ShowMessage("✅ Unpaid leave request submitted successfully!", "success");

                    // Clear form
                    txtStartDate.Text = "";
                    txtEndDate.Text = "";
                    txtDocumentDescription.Text = "";
                    txtFileName.Text = "";
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage("❌ Database error: " + sqlEx.Message, "error");
            }
            catch (FormatException)
            {
                ShowMessage("❌ Please enter valid dates.", "error");
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, "error");
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
    }
}