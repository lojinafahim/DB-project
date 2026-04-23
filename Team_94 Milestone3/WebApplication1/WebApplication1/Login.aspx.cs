using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = ""; // clear on load
        }

        protected void signin_Click(object sender, EventArgs e)
        {
            string empInput = txtEmpID.Text.Trim();
            string passInput = txtPassword.Text.Trim();

            // Validate Employee ID
            if (!int.TryParse(empInput, out int empID))
            {
                lblError.Text = "Employee ID must be a number.";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
            bool success = false;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT dbo.EmployeeLoginValidation(@employee_ID, @password)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@employee_ID", SqlDbType.Int).Value = empID;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar, 50).Value = passInput;

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    conn.Close();

                    if (result != null && result != DBNull.Value)
                    {
                        if (result is bool)
                            success = (bool)result;
                        else if (result is byte)
                            success = ((byte)result) == 1;
                        else
                            success = Convert.ToInt32(result) == 1;
                    }
                }
            }

            if (!success)
            {
                lblError.Text = "Login failed. Incorrect Employee ID or Password.";
                return;
            }

            // Clear error when login successful
            lblError.Text = "";

            Response.Redirect("Dashboard.aspx?empId=" + empID);

        }
    }
}
