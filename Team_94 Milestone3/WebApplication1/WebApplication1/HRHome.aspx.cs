using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class HRHome : System.Web.UI.Page
    {
        private string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HR_ID"] == null)
                Response.Redirect("HRLogin.aspx");

            if (!IsPostBack)
            {
                lblWelcome.Text = $"Logged in HR ID: {Session["HR_ID"]}";
                ClearAllErrors();
            }

            Page.MaintainScrollPositionOnPostBack = true;
        }

        // Missing hours deduction
        protected void btnAddHoursDed_Click(object sender, EventArgs e)
        {
            ClearAllErrors();

            // Validate Employee ID
            int empId;
            if (!int.TryParse(txtDeductHoursEmp.Text.Trim(), out empId) || empId <= 0)
            {
                lblHoursError.Text = "Please enter a valid Employee ID.";
                lblHoursError.CssClass = "error-label error-message";
                return;
            }

            // Validate Hours
            decimal hours;
            if (!decimal.TryParse(txtDeductHours.Text.Trim(), out hours) || hours <= 0)
            {
                lblHoursError.Text = "Please enter a valid number for missing hours.";
                lblHoursError.CssClass = "error-label error-message";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Deduction_hours", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblHoursError.Text = $"Successfully added {hours} hours deduction for Employee ID: {empId}.";
                        lblHoursError.CssClass = "error-label success-message";
                    }
                    else
                    {
                        lblHoursError.Text = $"No missing hours found for Employee ID: {empId}.";
                        lblHoursError.CssClass = "error-label info-message";
                    }
                }

                txtDeductHoursEmp.Text = "";
                txtDeductHours.Text = "";
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 547) // Foreign key constraint violation
                {
                    lblHoursError.Text = $"Employee ID {empId} not found in the system.";
                    lblHoursError.CssClass = "error-label error-message";
                }
                else
                {
                    lblHoursError.Text = $"Database error: {sqlEx.Message}";
                    lblHoursError.CssClass = "error-label error-message";
                }
            }
            catch (Exception ex)
            {
                lblHoursError.Text = $"Error: {ex.Message}";
                lblHoursError.CssClass = "error-label error-message";
            }
        }

        // Missing days deduction
        protected void btnAddDaysDed_Click(object sender, EventArgs e)
        {
            ClearAllErrors();

            // Validate Employee ID
            int empId;
            if (!int.TryParse(txtDeductDaysEmp.Text.Trim(), out empId) || empId <= 0)
            {
                lblDaysError.Text = "Please enter a valid Employee ID.";
                lblDaysError.CssClass = "error-label error-message";
                return;
            }

            // Validate Days
            decimal days;
            if (!decimal.TryParse(txtDeductDays.Text.Trim(), out days) || days <= 0)
            {
                lblDaysError.Text = "Please enter a valid number for missing days.";
                lblDaysError.CssClass = "error-label error-message";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Deduction_days", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_id", empId);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblDaysError.Text = $"Successfully added {days} days deduction for Employee ID: {empId}.";
                        lblDaysError.CssClass = "error-label success-message";
                    }
                    else
                    {
                        lblDaysError.Text = $"No missing days found for Employee ID: {empId} in current month.";
                        lblDaysError.CssClass = "error-label info-message";
                    }
                }

                txtDeductDaysEmp.Text = "";
                txtDeductDays.Text = "";
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 547) // Foreign key constraint violation
                {
                    lblDaysError.Text = $"Employee ID {empId} not found in the system.";
                    lblDaysError.CssClass = "error-label error-message";
                }
                else
                {
                    lblDaysError.Text = $"Database error: {sqlEx.Message}";
                    lblDaysError.CssClass = "error-label error-message";
                }
            }
            catch (Exception ex)
            {
                lblDaysError.Text = $"Error: {ex.Message}";
                lblDaysError.CssClass = "error-label error-message";
            }
        }

        // Unpaid leave deduction
        protected void btnAddUnpaidDed_Click(object sender, EventArgs e)
        {
            ClearAllErrors();

            // Validate Leave Request ID
            int leaveId;
            if (!int.TryParse(txtUnpaidLeaveID.Text.Trim(), out leaveId) || leaveId <= 0)
            {
                lblUnpaidError.Text = "Please enter a valid Leave Request ID.";
                lblUnpaidError.CssClass = "error-label error-message";
                return;
            }

            try
            {
                int empId;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Check if unpaid leave exists and get employee ID
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT Emp_ID FROM Unpaid_Leave WHERE request_ID = @rid", conn))
                    {
                        cmd.Parameters.AddWithValue("@rid", leaveId);
                        object o = cmd.ExecuteScalar();
                        if (o == null)
                        {
                            lblUnpaidError.Text = $"Leave Request ID {leaveId} not found in unpaid leave records.";
                            lblUnpaidError.CssClass = "error-label error-message";
                            return;
                        }
                        empId = Convert.ToInt32(o);
                    }

                    // Check if deduction already exists
                    using (SqlCommand cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM Deduction WHERE unpaid_ID = @leaveId AND type = 'unpaid'", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@leaveId", leaveId);
                        int existingDeductions = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        if (existingDeductions > 0)
                        {
                            lblUnpaidError.Text = $"Deduction already exists for Leave Request ID: {leaveId}.";
                            lblUnpaidError.CssClass = "error-label info-message";
                            return;
                        }
                    }

                    // Add unpaid deduction
                    using (SqlCommand cmd2 = new SqlCommand("Deduction_unpaid", conn))
                    {
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.AddWithValue("@employee_ID", empId);
                        int rowsAffected = cmd2.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblUnpaidError.Text = $"Successfully added unpaid leave deduction for Leave Request ID: {leaveId}.";
                            lblUnpaidError.CssClass = "error-label success-message";
                        }
                        else
                        {
                            lblUnpaidError.Text = $"No unpaid leave found for Employee ID: {empId} in current month.";
                            lblUnpaidError.CssClass = "error-label info-message";
                        }
                    }
                }

                txtUnpaidLeaveID.Text = "";
            }
            catch (Exception ex)
            {
                lblUnpaidError.Text = $"Error: {ex.Message}";
                lblUnpaidError.CssClass = "error-label error-message";
            }
        }

        // Generate payroll
        protected void btnGeneratePayroll_Click(object sender, EventArgs e)
        {
            ClearAllErrors();

            // Validate Year
            int year;
            if (!int.TryParse(txtPayrollYear.Text.Trim(), out year) || year < 2000 || year > 2100)
            {
                lblPayrollError.Text = "Please enter a valid year between 2000 and 2100.";
                lblPayrollError.CssClass = "error-label error-message";
                return;
            }

            // Validate Month
            int month;
            if (!int.TryParse(txtPayrollMonth.Text.Trim(), out month) || month < 1 || month > 12)
            {
                lblPayrollError.Text = "Please enter a valid month (1-12).";
                lblPayrollError.CssClass = "error-label error-message";
                return;
            }

            // Check if payroll already exists for this month/year
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    DateTime from = new DateTime(year, month, 1);
                    DateTime to = from.AddMonths(1).AddDays(-1);

                    using (SqlCommand cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM Payroll WHERE MONTH(from_date) = @month AND YEAR(from_date) = @year", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@month", month);
                        cmdCheck.Parameters.AddWithValue("@year", year);
                        int existingPayrolls = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        if (existingPayrolls > 0)
                        {
                            lblPayrollError.Text = $"Payroll for {month}/{year} already exists. Do you want to regenerate?";
                            lblPayrollError.CssClass = "error-label info-message";
                            // You could add a confirmation button here
                            return;
                        }
                    }

                    // Get all employees
                    using (SqlCommand cmdList = new SqlCommand("SELECT employee_id FROM Employee", conn))
                    using (SqlDataReader dr = cmdList.ExecuteReader())
                    {
                        var empIds = new System.Collections.Generic.List<int>();
                        while (dr.Read())
                            empIds.Add(Convert.ToInt32(dr["employee_id"]));

                        dr.Close();

                        int payrollsGenerated = 0;
                        foreach (int empId in empIds)
                        {
                            using (SqlCommand cmd = new SqlCommand("Add_Payroll", conn))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@employee_ID", empId);
                                cmd.Parameters.AddWithValue("@from", from);
                                cmd.Parameters.AddWithValue("@to", to);
                                cmd.ExecuteNonQuery();
                                payrollsGenerated++;
                            }
                        }

                        lblPayrollError.Text = $"Successfully generated payroll for {payrollsGenerated} employees for {month}/{year}.";
                        lblPayrollError.CssClass = "error-label success-message";
                    }
                }

                txtPayrollYear.Text = "";
                txtPayrollMonth.Text = "";
            }
            catch (SqlException sqlEx)
            {
                lblPayrollError.Text = $"Database error: {sqlEx.Message}";
                lblPayrollError.CssClass = "error-label error-message";
            }
            catch (Exception ex)
            {
                lblPayrollError.Text = $"Error: {ex.Message}";
                lblPayrollError.CssClass = "error-label error-message";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }

        private void ClearAllErrors()
        {
            lblHoursError.Text = "";
            lblDaysError.Text = "";
            lblUnpaidError.Text = "";
            lblPayrollError.Text = "";
        }
    }
}