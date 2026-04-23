using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Payroll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    int empId = int.Parse(Request.QueryString["empId"]);
                    ViewState["empId"] = empId;
                    LoadPayroll(empId);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadPayroll(int empId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM dbo.Last_month_payroll(@employee_ID)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPayroll.DataSource = dt;
                        gvPayroll.DataBind();

                        lblPayrollEmpty.Text = dt.Rows.Count == 0 ? "No payroll records found." : "";
                    }
                }
            }
        }

        protected void gvPayroll_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Apply color coding to financial columns
                // Adjust column indices based on your actual database columns

                // Example: If salary amount is in column 3 (index 2)
                if (e.Row.Cells.Count > 2)
                {
                    // Color salary amounts green
                    if (decimal.TryParse(e.Row.Cells[2].Text, out decimal salary))
                    {
                        e.Row.Cells[2].CssClass = "salary-amount";
                        e.Row.Cells[2].Text = string.Format("{0:C}", salary); // Format as currency
                    }
                }

                // Example: If deductions are in column 4 (index 3)
                if (e.Row.Cells.Count > 3)
                {
                    // Color deduction amounts red
                    if (decimal.TryParse(e.Row.Cells[3].Text, out decimal deduction))
                    {
                        e.Row.Cells[3].CssClass = "deduction-amount";
                        e.Row.Cells[3].Text = string.Format("{0:C}", deduction); // Format as currency
                    }
                }

                // Example: If net salary is in column 5 (index 4)
                if (e.Row.Cells.Count > 4)
                {
                    // Highlight net salary
                    if (decimal.TryParse(e.Row.Cells[4].Text, out decimal netSalary))
                    {
                        e.Row.Cells[4].CssClass = "net-salary";
                        e.Row.Cells[4].Text = string.Format("{0:C}", netSalary); // Format as currency
                    }
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            string empId = ViewState["empId"]?.ToString();
            if (!string.IsNullOrEmpty(empId))
            {
                Response.Redirect($"Dashboard.aspx?empId={empId}");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
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
    }
}