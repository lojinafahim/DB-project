using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class SubmitCompensationLeave : Page
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
                if (string.IsNullOrEmpty(txtCompensationDate.Text) ||
                    string.IsNullOrEmpty(txtOriginalWorkday.Text) ||
                    string.IsNullOrEmpty(txtReason.Text))
                {
                    ShowMessage("❌ Please fill in all required fields.", "error");
                    return;
                }

                // Validate dates
                DateTime compensationDate = DateTime.Parse(txtCompensationDate.Text);
                DateTime workdayDate = DateTime.Parse(txtOriginalWorkday.Text);

                if (compensationDate <= workdayDate)
                {
                    ShowMessage("❌ Compensation date must be after the original workday.", "error");
                    return;
                }

                int employeeID = Convert.ToInt32(Session["EmployeeID"]);
                string reason = txtReason.Text;
                string replacementID = txtReplacementID.Text;

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = new SqlCommand("Submit_Compensation_Leave", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@emp_id", employeeID);
                    command.Parameters.AddWithValue("@compensation_date", compensationDate);
                    command.Parameters.AddWithValue("@original_workday", workdayDate);
                    command.Parameters.AddWithValue("@reason", reason);
                    command.Parameters.AddWithValue("@replacement_id",
                        string.IsNullOrEmpty(replacementID) ? (object)DBNull.Value : replacementID);

                    connection.Open();
                    command.ExecuteNonQuery();

                    ShowMessage("✅ Compensation leave request submitted successfully!", "success");

                    // Clear form
                    txtCompensationDate.Text = "";
                    txtOriginalWorkday.Text = "";
                    txtReason.Text = "";
                    txtReplacementID.Text = "";
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