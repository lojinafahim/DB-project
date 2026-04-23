using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admin_RemoveDeductions : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager
                             .ConnectionStrings["MyDatabaseConnection"]
                             .ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Remove_Deductions", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    lblResult.Text = "Operation completed. Rows affected: " + rows;
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
            }
        }
    }
}
