using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration; // Use WebConfigurationManager instead of ConfigurationManager

namespace WebApplication1
{
    public partial class HRLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Clear message on page load
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            int empId;
            if (!int.TryParse(txtId.Text.Trim(), out empId))
            {
                lblMessage.Text = "Enter numeric Employee ID.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Use WebConfigurationManager instead
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    // Option A: call your HRLoginValidation function (returns BIT)
                    SqlCommand cmd = new SqlCommand("SELECT dbo.HRLoginValidation(@id, @pwd)", conn);
                    cmd.Parameters.AddWithValue("@id", empId);
                    cmd.Parameters.AddWithValue("@pwd", txtPassword.Text.Trim());

                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    // Check if login is successful
                    bool loginSuccess = false;

                    if (result != null && result != DBNull.Value)
                    {
                        // Handle different possible return types
                        if (result is bool)
                            loginSuccess = (bool)result;
                        else if (result is int)
                            loginSuccess = ((int)result) == 1;
                        else if (result is byte)
                            loginSuccess = ((byte)result) == 1;
                        else
                            loginSuccess = Convert.ToInt32(result) == 1;
                    }

                    if (loginSuccess)
                    {
                        Session["HR_ID"] = empId;
                        Response.Redirect("HRHome.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid credentials or not authorized for HR access.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (SqlException sqlEx)
                {
                    lblMessage.Text = $"Database error: {sqlEx.Message}";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error: {ex.Message}";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}