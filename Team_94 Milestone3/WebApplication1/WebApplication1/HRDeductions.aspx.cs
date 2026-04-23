using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class HRDeductions : System.Web.UI.Page
    {
        private readonly string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HR_ID"] == null) { Response.Redirect("HRLogin.aspx"); return; }
            if (!IsPostBack) lblWelcome.Text = $"Logged in HR ID: {HttpUtility.HtmlEncode(Session["HR_ID"].ToString())}";
            Page.MaintainScrollPositionOnPostBack = true;
        }

        protected void btnAddHoursDed_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtDeductHoursEmp.Text.Trim(), out int empId)) { lblStatus.Text = "Invalid Employee ID."; return; }

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand("Deduction_hours", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblStatus.Text = "Missing hours deduction process executed.";
            }
            catch (Exception ex) { lblStatus.Text = "Error: " + ex.Message; }
        }

        protected void btnAddDaysDed_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtDeductDaysEmp.Text.Trim(), out int empId)) { lblStatus.Text = "Invalid Employee ID."; return; }

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand("Deduction_days", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_id", empId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblStatus.Text = "Missing days deductions added (if any).";
            }
            catch (Exception ex) { lblStatus.Text = "Error: " + ex.Message; }
        }

        protected void btnAddUnpaidDed_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtUnpaidLeaveID.Text.Trim(), out int leaveId)) { lblStatus.Text = "Invalid Leave Request ID."; return; }

            try
            {
                int empId;
                using (var conn = new SqlConnection(connStr))
                {
                    using (var cmd = new SqlCommand("SELECT Emp_ID FROM Unpaid_Leave WHERE request_ID = @rid", conn))
                    {
                        cmd.Parameters.AddWithValue("@rid", leaveId);
                        conn.Open();
                        object o = cmd.ExecuteScalar();
                        if (o == null) { lblStatus.Text = "Unpaid leave not found."; return; }
                        empId = Convert.ToInt32(o);
                    }

                    using (var cmd2 = new SqlCommand("Deduction_unpaid", conn))
                    {
                        cmd2.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd2.Parameters.AddWithValue("@employee_ID", empId);
                        cmd2.ExecuteNonQuery();
                    }
                }

                lblStatus.Text = "Unpaid leave deduction added.";
            }
            catch (Exception ex) { lblStatus.Text = "Error: " + ex.Message; }
        }

        protected void btnBack_Click(object sender, EventArgs e) => Response.Redirect("~/HRHome.aspx");

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }
    }
}
