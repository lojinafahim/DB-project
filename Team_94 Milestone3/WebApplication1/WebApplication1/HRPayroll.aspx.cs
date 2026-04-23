using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;

namespace WebApplication1
{
    public partial class HRPayroll : System.Web.UI.Page
    {
        private readonly string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HR_ID"] == null) { Response.Redirect("HRLogin.aspx"); return; }
            if (!IsPostBack) lblWelcome.Text = $"Logged in HR ID: {HttpUtility.HtmlEncode(Session["HR_ID"].ToString())}";
            Page.MaintainScrollPositionOnPostBack = true;
        }

        protected void btnGeneratePayroll_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtPayrollYear.Text.Trim(), out int year) || !int.TryParse(txtPayrollMonth.Text.Trim(), out int month))
            {
                lblStatus.Text = "Invalid year or month.";
                return;
            }

            try
            {
                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (var cmdList = new SqlCommand("SELECT employee_id FROM Employee", conn))
                    using (var dr = cmdList.ExecuteReader())
                    {
                        var empIds = new System.Collections.Generic.List<int>();
                        while (dr.Read()) empIds.Add(Convert.ToInt32(dr["employee_id"]));
                        dr.Close();

                        foreach (int empId in empIds)
                        {
                            DateTime from = new DateTime(year, month, 1);
                            DateTime to = from.AddMonths(1).AddDays(-1);

                            using (var cmd = new SqlCommand("Add_Payroll", conn))
                            {
                                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@employee_ID", empId);
                                cmd.Parameters.AddWithValue("@from", from);
                                cmd.Parameters.AddWithValue("@to", to);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                }

                lblStatus.Text = $"Payroll generated for {month}/{year}.";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error generating payroll: " + ex.Message;
            }
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
