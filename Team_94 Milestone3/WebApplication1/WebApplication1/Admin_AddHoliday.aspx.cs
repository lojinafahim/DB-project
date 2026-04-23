using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Admin_AddHoliday : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("~/Admin/AdminLogin.aspx");
            }
        }

        // Name server-side validator (letters + spaces only, max 50)
        protected void valNameFormat_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var v = (args.Value ?? string.Empty).Trim();
            if (string.IsNullOrEmpty(v) || v.Length > 50)
            {
                args.IsValid = false;
                return;
            }

            foreach (char c in v)
            {
                if (!char.IsLetter(c) && c != ' ')
                {
                    args.IsValid = false;
                    return;
                }
            }

            args.IsValid = true;
        }

        // Server-side strict ISO date validator using TryParseExact
        protected void valFromDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string s = (args.Value ?? string.Empty).Trim();
            args.IsValid = DateTime.TryParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out _);
        }

        protected void valToDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string s = (args.Value ?? string.Empty).Trim();
            args.IsValid = DateTime.TryParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out _);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Clear previous message immediately so stale success doesn't remain
            lblRes.Text = string.Empty;

            // Run validators
            Page.Validate();
            if (!Page.IsValid)
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "Please fix validation errors.";
                return;
            }

            string name = txtHolidayName.Text.Trim();

            // final defensive server-side check (redundant but safe)
            if (string.IsNullOrEmpty(name) || name.Length > 50)
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "Holiday name is required and must be 1-50 characters.";
                return;
            }
            foreach (char c in name)
            {
                if (!char.IsLetter(c) && c != ' ')
                {
                    lblRes.ForeColor = System.Drawing.Color.Red;
                    lblRes.Text = "Holiday name must contain letters and spaces only.";
                    return;
                }
            }

            // Parse dates using exact format
            if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime fromDate))
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "From date parsing failed (must be YYYY-MM-DD).";
                return;
            }

            if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime toDate))
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "To date parsing failed (must be YYYY-MM-DD).";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Ensure Holiday table exists by calling existing proc if needed
                    string ensureSql = @"
IF OBJECT_ID('dbo.Holiday', 'U') IS NULL
BEGIN
    EXEC dbo.Create_Holiday;
END";
                    using (SqlCommand ensureCmd = new SqlCommand(ensureSql, conn))
                    {
                        ensureCmd.CommandType = CommandType.Text;
                        ensureCmd.ExecuteNonQuery();
                    }

                    // Insert via stored procedure
                    using (SqlCommand cmd = new SqlCommand("dbo.Add_Holiday", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@holiday_name", name);
                        cmd.Parameters.Add("@from_date", SqlDbType.Date).Value = fromDate.Date;
                        cmd.Parameters.Add("@to_date", SqlDbType.Date).Value = toDate.Date;
                        cmd.ExecuteNonQuery();
                    }

                    lblRes.ForeColor = System.Drawing.Color.Green;
                    lblRes.Text = "Holiday added successfully.";
                }
            }
            catch (SqlException sx)
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "Database error: " + sx.Message;
            }
            catch (Exception ex)
            {
                lblRes.ForeColor = System.Drawing.Color.Red;
                lblRes.Text = "Error: " + ex.Message;
            }
        }
    }
}
