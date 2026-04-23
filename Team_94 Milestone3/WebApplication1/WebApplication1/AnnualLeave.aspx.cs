using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class AnnualLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    int empId = int.Parse(Request.QueryString["empId"]);
                    ViewState["empId"] = empId;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }


        protected void btnSubmitLeave_Click(object sender, EventArgs e)
        {
            lblLeaveStatus.Text = ""; // Clear previous messages

            try
            {
                int empId = (int)ViewState["empId"];

                if (!int.TryParse(txtReplacementEmp.Text.Trim(), out int replacementEmp))
                {
                    lblLeaveStatus.ForeColor = System.Drawing.Color.Red;
                    lblLeaveStatus.Text = "Please enter a valid Replacement Employee ID.";
                    return;
                }

                if (!DateTime.TryParse(txtStartDate.Text.Trim(), out DateTime startDate) ||
                    !DateTime.TryParse(txtEndDate.Text.Trim(), out DateTime endDate))
                {
                    lblLeaveStatus.ForeColor = System.Drawing.Color.Red;
                    lblLeaveStatus.Text = "Please enter valid Start and End dates (yyyy-mm-dd).";
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("Submit_annual", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@employee_ID", empId);
                        cmd.Parameters.AddWithValue("@replacement_emp", replacementEmp);
                        cmd.Parameters.AddWithValue("@start_date", startDate);
                        cmd.Parameters.AddWithValue("@end_date", endDate);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        lblLeaveStatus.ForeColor = System.Drawing.Color.Green;
                        lblLeaveStatus.Text = "Annual leave submitted successfully!";

                        // Clear form
                        txtReplacementEmp.Text = "";
                        txtStartDate.Text = "";
                        txtEndDate.Text = "";
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                // Check for specific error types
                if (sqlEx.Number == 547) // Foreign key constraint violation
                {
                    lblLeaveStatus.ForeColor = System.Drawing.Color.Red;
                    lblLeaveStatus.Text = "Replacement Employee ID does not exist or is invalid.";
                }
                else
                {
                    lblLeaveStatus.ForeColor = System.Drawing.Color.Red;
                    lblLeaveStatus.Text = "Cannot apply for annual leave. Try to change the data or check for your eligibility to do so.";
                }
            }
            catch (Exception ex)
            {
                lblLeaveStatus.ForeColor = System.Drawing.Color.Red;
                lblLeaveStatus.Text = "An error occurred. Please try again.";
            }
        }

        // ADD THESE MISSING METHODS:
        protected void btnHome_Click(object sender, EventArgs e)
        {
            int empId = (int)ViewState["empId"];
            Response.Redirect("Dashboard.aspx?empId=" + empId);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
        protected void btnOtherActions_Click(object sender, EventArgs e)
        {
            // Try multiple ways to get the employee ID
            string empId = "";

            // 1. Try ViewState
            if (ViewState["empId"] != null)
            {
                empId = ViewState["empId"].ToString();
            }
            // 2. Try Session
            else if (Session["EmployeeID"] != null)
            {
                empId = Session["EmployeeID"].ToString();
            }
            // 3. Try Query String
            else if (Request.QueryString["empId"] != null)
            {
                empId = Request.QueryString["empId"];
            }

            // Redirect to EmpDashboard with the employee ID
            if (!string.IsNullOrEmpty(empId))
            {
                Response.Redirect($"EmpDashboard.aspx?empId={empId}");
            }
            else
            {
                // If no employee ID found, redirect to login
                Response.Redirect("Login.aspx");
            }
        }

        // Also add this if you have a btnBack in your .aspx file:
        protected void btnBack_Click(object sender, EventArgs e)
        {
            int empId = (int)ViewState["empId"];
            Response.Redirect("Dashboard.aspx?empId=" + empId);
        }
    }
}