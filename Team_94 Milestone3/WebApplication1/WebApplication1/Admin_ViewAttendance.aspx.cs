using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using WebApplication1;

namespace WebApplication1
{
    public partial class Admin_ViewAttendance : Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Show last message from tools page if exists
                if (Session["LastMessage"] != null)
                {
                    lblInfo.Text = Session["LastMessage"].ToString();
                    Session["LastMessage"] = null;  // optional clear
                }

                LoadAttendance();
            }
        }

        private void LoadAttendance()
        {
            const string sql = @"
                SELECT TOP 200 *
                FROM Attendance
                ORDER BY [date] DESC, emp_ID;";

            var dt = new DataTable();

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand(sql, conn))
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }

                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();
            }
            catch (SqlException ex)
            {
                lblInfo.Text = "DB error while loading attendance: " + ex.Message;
            }
        }

        protected void btnBackTools_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_AttendanceTools.aspx");
        }
    }
}
