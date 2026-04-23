using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admin_ViewProfiles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] as string != "Admin")
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
                LoadProfiles();
        }

        private void LoadProfiles()
        {
            string connStr = WebConfigurationManager
                             .ConnectionStrings["MyDatabaseConnection"]
                             .ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM allEmployeeProfiles", conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProfiles.DataSource = dt;
                gvProfiles.DataBind();
            }
        }
    }
}
