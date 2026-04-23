using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class EmpDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["empId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        private string EmpId()
        {
            return Request.QueryString["empId"];
        }

        protected void btnAccidental_Click(object sender, EventArgs e)
        {
            Response.Redirect("Submit_Accidental.aspx?empId=" + EmpId());
        }

        protected void btnMedical_Click(object sender, EventArgs e)
        {
            Response.Redirect("Submit_Medical.aspx?empId=" + EmpId());
        }

        protected void btnUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("Submit_Unpaid.aspx?empId=" + EmpId());
        }

        protected void btnCompensation_Click(object sender, EventArgs e)
        {
            Response.Redirect("Submit_Compensation.aspx?empId=" + EmpId());
        }

        protected void btnApproveUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("Upperboard_approve_unpaids.aspx?empId=" + EmpId());
        }

        protected void btnApproveAnnual_Click(object sender, EventArgs e)
        {
            Response.Redirect("Upperboard_approve_annual.aspx?empId=" + EmpId());
        }

        protected void btnEvaluation_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dean_andHR_Evaluation.aspx?empId=" + EmpId());
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx?empId=" + EmpId());
        }

        protected void btnMedSubmit_Click(object sender, EventArgs e)
        {
            // existing submit code unchanged
        }


    }
}