using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    int empId = int.Parse(Request.QueryString["empId"]);
                    ViewState["empId"] = empId;

                    // Automatically load attendance data on page load
                    LoadAttendanceData(empId);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadAttendanceData(int empId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM dbo.MyAttendance(@employee_ID)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvAttendanceCurrent.DataSource = dt;
                        gvAttendanceCurrent.DataBind();

                        // Set empty message if no records
                        lblAttendanceEmpty.Text = (dt.Rows.Count == 0) ? "No attendance records found." : "";
                    }
                }
            }
        }

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

        // Remove or comment out the button click method since we removed the GO button
        /*
        protected void btnLoadAttendance_Click(object sender, EventArgs e)
        {
            int empId = (int)ViewState["empId"];
            LoadAttendanceData(empId);
        }
        */
    }
}