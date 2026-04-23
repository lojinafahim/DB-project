using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Submit_Medical : Page
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

        // ✅ KEEPING YOUR EXACT SUBMIT FUNCTIONALITY (NO CHANGES)
        protected void btnMedSubmit_Click(object sender, EventArgs e)
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
                lblMedMsg.ForeColor = System.Drawing.Color.Red;
                lblMedMsg.Text = "Employee ID not found. Please login again.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtMedStart.Text) ||
                string.IsNullOrWhiteSpace(txtMedEnd.Text) ||
                string.IsNullOrWhiteSpace(ddlMedType.SelectedValue) ||
                string.IsNullOrWhiteSpace(rblInsurance.SelectedValue) ||
                string.IsNullOrWhiteSpace(txtDocDesc.Text) ||
                string.IsNullOrWhiteSpace(txtFileName.Text))
            {
                lblMedMsg.ForeColor = System.Drawing.Color.Red;
                lblMedMsg.Text = "Please fill all required fields.";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("Submit_medical", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@employee_ID", Convert.ToInt32(empId));
                cmd.Parameters.AddWithValue("@start_date", txtMedStart.Text);
                cmd.Parameters.AddWithValue("@end_date", txtMedEnd.Text);
                cmd.Parameters.AddWithValue("@medical_type", ddlMedType.SelectedValue);
                cmd.Parameters.AddWithValue("@insurance_status", Convert.ToBoolean(Convert.ToInt32(rblInsurance.SelectedValue)));
                cmd.Parameters.AddWithValue("@disability_details", (object)txtDisability.Text ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@document_description", txtDocDesc.Text);
                cmd.Parameters.AddWithValue("@file_name", txtFileName.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                lblMedMsg.ForeColor = System.Drawing.Color.Green;
                lblMedMsg.Text = "✅ Medical leave application submitted successfully.";
            }
        }

        // ✅ BACK TO DASHBOARD (SAME AS SUBMIT_UNPAID)
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