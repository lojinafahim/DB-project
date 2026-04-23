using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear any existing message on page load
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }

            // REMOVE OR COMMENT OUT this automatic redirect
            // This is what's skipping the login page
            // if (!IsPostBack && Session["Role"] as string == "Admin")
            // {
            //     Response.Redirect("AdminDashboard.aspx");
            // }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Hard-coded admin credentials
            string adminId = "admin";
            string adminPass = "1234";

            // Trim inputs for safety
            string inputId = txtAdminId.Text.Trim();
            string inputPass = txtPassword.Text.Trim();

            if (inputId == adminId && inputPass == adminPass)
            {
                // Mark this session as admin
                Session["Role"] = "Admin";

                // Go to dashboard
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid admin ID or password.";
            }
        }
    }
}