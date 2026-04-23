using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Dean_andHR_Evaluation : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null) Response.Redirect("~/Login.aspx");
                LoadEmployees();
            }
        }

        private void LoadEmployees()
        {
            int currentEmployeeID = Convert.ToInt32(Session["EmployeeID"]);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT e.employee_id, e.first_name + ' ' + e.last_name as EmployeeName, r.role_name
                    FROM Employee e
                    INNER JOIN Employee_Role er ON e.employee_id = er.emp_ID
                    INNER JOIN Role r ON er.role_name = r.role_name
                    WHERE e.dept_name = (SELECT dept_name FROM Employee WHERE employee_id = @currentEmployeeID)
                    AND e.employee_id != @currentEmployeeID
                    AND r.role_name IN ('Lecturer', 'Teaching Assistant')
                    ORDER BY e.first_name";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@currentEmployeeID", currentEmployeeID);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    ddlEmployee.DataSource = reader;
                    ddlEmployee.DataTextField = "EmployeeName";
                    ddlEmployee.DataValueField = "employee_id";
                    ddlEmployee.DataBind();

                    ddlEmployee.Items.Insert(0, new ListItem("-- Select Employee --", ""));
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Get values from form
                int employeeID;
                if (!int.TryParse(ddlEmployee.SelectedValue, out employeeID) || employeeID == 0)
                {
                    ShowMessage("❌ Please select an employee to evaluate.", "error");
                    return;
                }

                // Get rating from hidden field (star rating)
                int rating;
                if (!int.TryParse(hdnRating.Value, out rating) || rating < 1 || rating > 5)
                {
                    ShowMessage("❌ Please select a valid rating (1-5 stars).", "error");
                    return;
                }

                string comments = txtComments.Text;
                string semester = ddlSemester.SelectedValue;

                if (string.IsNullOrEmpty(semester))
                {
                    ShowMessage("❌ Please select a semester.", "error");
                    return;
                }

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = new SqlCommand("Dean_andHR_Evaluation", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@employee_ID", employeeID);
                    command.Parameters.AddWithValue("@rating", rating);
                    command.Parameters.AddWithValue("@comment", comments);
                    command.Parameters.AddWithValue("@semester", semester);

                    connection.Open();
                    int result = command.ExecuteNonQuery();

                    ShowMessage("✅ Employee evaluation submitted successfully!", "success");

                    // Clear form
                    ddlEmployee.SelectedIndex = 0;
                    txtComments.Text = "";
                    ddlSemester.SelectedIndex = 0;

                    // Reset star rating to default (3 stars)
                    hdnRating.Value = "3";

                    // Reset JavaScript star selection
                    ScriptManager.RegisterStartupScript(this, GetType(), "ResetStars", "resetStarRating();", true);
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
            lblMessage.Text = message;

            // Remove any existing message classes
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