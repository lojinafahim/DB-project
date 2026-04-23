using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Deductions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    int empId = int.Parse(Request.QueryString["empId"]);
                    ViewState["empId"] = empId; // Store in ViewState
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnLoadDeductions_Click(object sender, EventArgs e)
        {
            // Get empId from ViewState instead of QueryString
            if (ViewState["empId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int empId = (int)ViewState["empId"];

            if (!int.TryParse(txtDeductionMonth.Text.Trim(), out int month) || month < 1 || month > 12)
            {
                lblDeductionsEmpty.Text = "Please enter a valid month (1-12).";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM dbo.Deductions_Attendance(@employee_ID, @month)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    cmd.Parameters.AddWithValue("@month", month);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvDeductions.DataSource = dt;
                    gvDeductions.DataBind();

                    lblDeductionsEmpty.Text = dt.Rows.Count == 0 ? "No records found." : "";
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Get empId from ViewState
            if (ViewState["empId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

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

        // Add the RowDataBound method that's referenced in the ASPX
        protected void gvDeductions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find columns that contain deduction amounts and color them red
                // You'll need to adjust the column indices based on your actual data
                // For example, if deduction amount is in column 3 (index 2):
                if (e.Row.Cells.Count > 2)
                {
                    // Check if this cell contains a numeric value (deduction amount)
                    if (decimal.TryParse(e.Row.Cells[2].Text, out decimal deduction))
                    {
                        e.Row.Cells[2].CssClass = "deduction-cell";
                        e.Row.Cells[2].Text = string.Format("{0:C}", deduction); // Format as currency
                    }
                }
            }
        }
    }
}