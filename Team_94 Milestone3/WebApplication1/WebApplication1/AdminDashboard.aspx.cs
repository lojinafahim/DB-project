using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class AdminDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only allow access if logged in as admin
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }


        protected void btnViewProfiles_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_ViewProfiles.aspx");
        }

        protected void btnEmployeesPerDept_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_EmployeesPerDept.aspx");
        }

        protected void btnRejectedMedical_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_RejectedMedicals.aspx");
        }

        protected void btnRemoveDeductions_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_RemoveDeductions.aspx");
        }

        protected void btnUpdateAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_UpdateAttendance.aspx");
        }

        protected void btnAddHoliday_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_AddHoliday.aspx");
        }

        protected void btnInitAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_InitiateAttendance.aspx");
        }

        protected void btnAttendanceTools_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_AttendanceTools.aspx");
        }
    }
}