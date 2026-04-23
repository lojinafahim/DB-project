using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;

namespace WebApplication1
{
    // IMPORTANT: class name must match Inherits + designer partial class
    public partial class Admin_AttendanceTools : Page
    {
        // reads MyConn from Web.config
        private readonly string connStr =
    ConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                lblStatus.Text = "";
            }
        }

        // 1) Yesterday's attendance for all employees
        protected void btnGetYesterday_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            DateTime yesterday = DateTime.Today.AddDays(-1);

            const string sql = @"
                SELECT attendance_ID, emp_ID, [date], check_in_time, check_out_time, total_duration, status
                FROM Attendance
                WHERE CAST([date] AS DATE) = @date;";

            var dt = new DataTable();

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand(sql, conn))
                using (var da = new SqlDataAdapter(cmd))
                {
                    cmd.Parameters.Add("@date", SqlDbType.Date).Value = yesterday.Date;
                    da.Fill(dt);
                }

                gvResults.DataSource = dt;
                gvResults.DataBind();

                lblMessage.Text = $"Found {dt.Rows.Count} attendance rows for {yesterday:yyyy-MM-dd}.";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }

        // 2) Winter performance (Dec/Jan/Feb)
        protected void btnGetWinter_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            const string sql = @"
                SELECT a.emp_ID, COUNT(*) AS AttendedDays
                FROM Attendance a
                WHERE UPPER(ISNULL(a.status,'')) = 'ATTENDED'
                  AND MONTH(a.[date]) IN (12,1,2)
                GROUP BY a.emp_ID
                ORDER BY AttendedDays DESC;";

            var dt = new DataTable();

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand(sql, conn))
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }

                gvResults.DataSource = dt;
                gvResults.DataBind();

                lblMessage.Text = $"Returned {dt.Rows.Count} employee winter performance rows.";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }

        // 3) Remove attendance on official holidays (uses Remove_Holiday proc)
        protected void btnRemoveHolidays_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand("Remove_Holiday", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Attendance records on official holidays have been removed (via Remove_Holiday).";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }

        // 4) Remove unattended dayoff for a certain employee (current month) – uses Remove_DayOff
        protected void btnRemoveUnattended_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            if (!int.TryParse(txtUnattendedEmp.Text?.Trim(), out int empId))
            {
                lblMessage.Text = "Please enter a valid numeric Employee ID.";
                return;
            }

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand("Remove_DayOff", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@employee_ID", SqlDbType.Int).Value = empId;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = $"Unattended day-off attendance rows for employee {empId} " +
                                  "in the current month have been removed (via Remove_DayOff).";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }

        // 5) Remove approved leaves for a certain employee – uses Remove_Approved_Leaves
        protected void btnRemoveApprovedLeaves_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            if (!int.TryParse(txtApprovedLeavesEmp.Text?.Trim(), out int empId))
            {
                lblMessage.Text = "Please enter a valid numeric employee id.";
                return;
            }

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = new SqlCommand("Remove_Approved_Leaves", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@employee_id", SqlDbType.Int).Value = empId;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = $"Attendance rows covered by approved leaves for employee {empId} " +
                                  "have been removed (via Remove_Approved_Leaves).";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }

        // 6) Replace employee in attendance between a date range – uses Replace_employee
        protected void btnReplaceEmployee_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            if (!int.TryParse(txtReplaceFrom.Text?.Trim(), out int fromId) ||
                !int.TryParse(txtReplaceTo.Text?.Trim(), out int toId))
            {
                lblMessage.Text = "Please enter valid integer employee IDs for Replace From/To.";
                return;
            }

            // We allow either a single date (used as from/to) or automatic full range
            DateTime fromDate, toDate;

            using (var conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (!string.IsNullOrWhiteSpace(txtReplaceDate.Text))
                {
                    if (!DateTime.TryParseExact(
                            txtReplaceDate.Text.Trim(),
                            "yyyy-MM-dd",
                            CultureInfo.InvariantCulture,
                            DateTimeStyles.None,
                            out var parsedDate))
                    {
                        lblMessage.Text = "Date not recognized. Use YYYY-MM-DD.";
                        return;
                    }

                    fromDate = parsedDate.Date;
                    toDate = parsedDate.Date;
                }
                else
                {
                    // If no date given, use min/max attendance dates for Emp1
                    using (var cmdRange = new SqlCommand(
                               @"SELECT MIN([date]), MAX([date]) 
                                 FROM Attendance 
                                 WHERE emp_ID = @id;", conn))
                    {
                        cmdRange.Parameters.Add("@id", SqlDbType.Int).Value = fromId;
                        using (var r = cmdRange.ExecuteReader())
                        {
                            if (!r.Read() || r.IsDBNull(0) || r.IsDBNull(1))
                            {
                                lblMessage.Text = "No attendance records found for the 'From' employee.";
                                return;
                            }

                            fromDate = r.GetDateTime(0).Date;
                            toDate = r.GetDateTime(1).Date;
                        }
                    }
                }

                try
                {
                    using (var cmd = new SqlCommand("Replace_employee", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Emp1_ID", SqlDbType.Int).Value = fromId;
                        cmd.Parameters.Add("@Emp2_ID", SqlDbType.Int).Value = toId;
                        cmd.Parameters.Add("@from_date", SqlDbType.Date).Value = fromDate;
                        cmd.Parameters.Add("@to_date", SqlDbType.Date).Value = toDate;

                        cmd.ExecuteNonQuery();
                    }

                    lblMessage.Text =
                        $"Replace_employee executed: replaced employee {fromId} with {toId} " +
                        $"from {fromDate:yyyy-MM-dd} to {toDate:yyyy-MM-dd}.";
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "DB error: " + ex.Message;
                }
            }
        }

        // 7) Update employment status daily – uses Update_Employment_Status for ALL employees
        protected void btnUpdateEmployment_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblStatus.Text = "";

            try
            {
                var updatedIds = new List<int>();

                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // get all employee IDs
                    var ids = new List<int>();
                    using (var cmdGet = new SqlCommand("SELECT employee_id FROM Employee;", conn))
                    using (var reader = cmdGet.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ids.Add(reader.GetInt32(0));
                        }
                    }

                    // call Update_Employment_Status for each employee
                    foreach (int id in ids)
                    {
                        using (var cmdUpdate = new SqlCommand("Update_Employment_Status", conn))
                        {
                            cmdUpdate.CommandType = System.Data.CommandType.StoredProcedure;
                            cmdUpdate.Parameters.Add("@Employee_ID", SqlDbType.Int).Value = id;
                            cmdUpdate.ExecuteNonQuery();
                        }

                        updatedIds.Add(id);
                    }
                }

                lblMessage.Text = "Employment statuses updated for all employees (via Update_Employment_Status).";
                lblStatus.Text = $"Total employees processed: {updatedIds.Count}.";
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "DB error: " + ex.Message;
            }
        }
        protected void btnBackDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }


    }


}
