using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Dashboard : System.Web.UI.Page
    {
        // Properties to access controls using FindControl
        private Label LblEmpIDSidebar
        {
            get { return (Label)FindControl("lblEmpIDSidebar"); }
        }

        private Label LblEmployeeName
        {
            get { return (Label)FindControl("lblEmployeeName"); }
        }

        private ImageButton BtnLogout
        {
            get { return (ImageButton)FindControl("btnLogout"); }
        }

        private LinkButton LnkOtherActions
        {
            get { return (LinkButton)FindControl("lnkOtherActions"); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["empId"] != null)
                {
                    string empId = Request.QueryString["empId"];
                    ViewState["empId"] = empId;
                    Session["EmployeeID"] = empId; // Also store in session for consistency

                    if (LblEmpIDSidebar != null)
                        LblEmpIDSidebar.Text = "Quick Actions";

                    // Get and display employee name
                    string employeeName = GetEmployeeName(empId);

                    if (LblEmployeeName != null)
                        LblEmployeeName.Text = employeeName;

                    // Attach event handlers if controls exist
                    if (BtnLogout != null)
                    {
                        BtnLogout.Click += btnLogout_Click;
                    }

                    if (LnkOtherActions != null)
                    {
                        LnkOtherActions.Click += btnOtherActions_Click;
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private string GetEmployeeName(string empId)
        {
            string employeeName = "Employee";

            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT first_name, last_name FROM Employee WHERE employee_id = @empId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@empId", empId);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            string firstName = reader["first_name"].ToString();
                            string lastName = reader["last_name"].ToString();
                            employeeName = $"{firstName} {lastName}";
                        }
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting employee name: {ex.Message}");
                employeeName = "Employee";
            }

            return employeeName;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
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