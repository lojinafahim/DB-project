using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Submit_accidental : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Check both session and query string for employee ID
                if (Session["EmployeeID"] == null && Request.QueryString["empId"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // If query string has empId but session doesn't, set it
                if (Session["EmployeeID"] == null && Request.QueryString["empId"] != null)
                {
                    Session["EmployeeID"] = Request.QueryString["empId"];
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string empId = "";

            // Get employee ID from session or query string
            if (Session["EmployeeID"] != null)
            {
                empId = Session["EmployeeID"].ToString();
            }
            else if (Request.QueryString["empId"] != null)
            {
                empId = Request.QueryString["empId"];
                Session["EmployeeID"] = empId;
            }
            else
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // ✅ Validate empty dates
            if (string.IsNullOrWhiteSpace(txtStart.Text) || string.IsNullOrWhiteSpace(txtEnd.Text))
            {
                lblMsg.Text = "❌ Please select BOTH start date and end date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            DateTime start, end;

            // ✅ Validate date format
            bool isStartValid = DateTime.TryParse(txtStart.Text, out start);
            bool isEndValid = DateTime.TryParse(txtEnd.Text, out end);

            if (!isStartValid || !isEndValid)
            {
                lblMsg.Text = "❌ Invalid date format. Please enter a valid date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // ✅ Check date logic
            if (end < start)
            {
                lblMsg.Text = "❌ End date cannot be before start date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("Submit_accidental", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@employee_ID", Convert.ToInt32(empId));
                cmd.Parameters.AddWithValue("@start_date", start);
                cmd.Parameters.AddWithValue("@end_date", end);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "✅ Accidental Leave Submitted Successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }

        // ✅ BACK TO DASHBOARD
        protected void btnBack_Click(object sender, EventArgs e)
        {
            string redirectUrl = "EmpDashboard.aspx";

            if (Session["EmployeeID"] != null)
            {
                redirectUrl += "?empId=" + Session["EmployeeID"].ToString();
            }
            else if (Request.QueryString["empId"] != null)
            {
                redirectUrl += "?empId=" + Request.QueryString["empId"];
            }

            Response.Redirect(redirectUrl);
        }

       
    }
}