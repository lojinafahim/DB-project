using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class LeaveStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    int empId = int.Parse(Request.QueryString["empId"]);
                    ViewState["empId"] = empId;
                    LoadLeaveStatus(empId); // Load data on first visit
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadLeaveStatus(int empId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Call your existing function
                string query = "SELECT * FROM dbo.status_leaves(@employee_ID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", empId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvLeaveStatus.DataSource = dt;
                        gvLeaveStatus.DataBind();

                        lblEmptyMessage.Text = dt.Rows.Count == 0 ?
                            "No leave records found for current month." : "";
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
            Response.Redirect("Home.aspx"); // Changed to Home.aspx
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

        protected void gvLeaveStatus_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the Status cell - assuming final_approval_status is one of the columns
                // You need to adjust the index based on your actual columns
                // For example, if it's the 3rd column (index 2):
                if (e.Row.Cells.Count > 2) // Make sure we have enough columns
                {
                    TableCell statusCell = e.Row.Cells[2];
                    string status = statusCell.Text.ToLower();

                    // Apply CSS classes based on status
                    if (status.Contains("approved") || status.Contains("granted") || status == "1" || status == "true")
                    {
                        statusCell.CssClass = "status-approved";
                        statusCell.Text = "Approved";
                    }
                    else if (status.Contains("pending") || status.Contains("waiting") || string.IsNullOrEmpty(status))
                    {
                        statusCell.CssClass = "status-pending";
                        statusCell.Text = "Pending";
                    }
                    else if (status.Contains("rejected") || status.Contains("denied"))
                    {
                        statusCell.CssClass = "status-rejected";
                        statusCell.Text = "Rejected";
                    }
                }
            }
        }
    }
}