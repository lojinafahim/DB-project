using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admin_UpdateAttendance : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtEmpId.Text, out int empId))
            {
                lblMsg.Text = "Please enter a valid numeric Employee ID.";
                return;
            }

            string connStr = WebConfigurationManager
                             .ConnectionStrings["MyDatabaseConnection"]
                             .ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Update_Attendance", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Employee_id", empId);
                    cmd.Parameters.AddWithValue("@check_in_time", txtCheckIn.Text);
                    cmd.Parameters.AddWithValue("@check_out_time", txtCheckOut.Text);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "Attendance updated successfully for employee " + empId + ".";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}
