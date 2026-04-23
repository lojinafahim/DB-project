using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admin_InitiateAttendance : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void btnInit_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager
                             .ConnectionStrings["MyDatabaseConnection"]
                             .ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Initiate_Attendance", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    lblRes.Text = "Attendance initialized for today. Rows affected: " + rows;
                }
            }
            catch (Exception ex)
            {
                lblRes.Text = "Error: " + ex.Message;
            }
        }
    }
}