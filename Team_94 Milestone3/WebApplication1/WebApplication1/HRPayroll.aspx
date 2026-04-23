<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRPayroll.aspx.cs" Inherits="WebApplication1.HRPayroll" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generate Payroll</title>
    <style>
        body{font-family:'Segoe UI',Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(135deg,#5D8AA8 0%,#7A9EB1 50%,#98AFC7 100%);margin:0;padding:20px}
        .dashboard-container{max-width:1100px;margin:20px auto;padding:20px;background:#fff;border-radius:8px;box-shadow:0 6px 18px rgba(0,0,0,0.08)}
        .header-section{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px}
        .form-group{display:flex;align-items:center;gap:10px;flex-wrap:wrap}
        .form-label{font-weight:600;color:#2c3e50}
        .form-input{padding:10px 12px;border:1px solid #ddd;border-radius:8px}
        .submit-btn{background:linear-gradient(135deg,#9b59b6,#8e44ad);color:#fff;padding:10px 16px;border-radius:8px;border:none;cursor:pointer}
        .status-label{display:inline-block;margin-top:12px;color:#2c3e50;font-weight:600}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <div class="header-section">
                <div>
                    <h2>Generate Monthly Payroll</h2>
                    <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-label" />
                </div>
                <div>
                    <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="action-button" />
                    &nbsp;
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="action-button" />
                </div>
            </div>

            <div class="payroll-section">
                <div class="form-group">
                    <span class="form-label">Year:</span>
                    <asp:TextBox ID="txtPayrollYear" runat="server" CssClass="form-input" Width="100px" />
                    <span class="form-label">Month:</span>
                    <asp:TextBox ID="txtPayrollMonth" runat="server" CssClass="form-input" Width="80px" />
                    <asp:Button ID="btnGeneratePayroll" runat="server" Text="Generate All Payrolls" OnClick="btnGeneratePayroll_Click" CssClass="submit-btn" />
                </div>

                <asp:Label ID="lblStatus" runat="server" CssClass="status-label" />
            </div>
        </div>
    </form>
</body>
</html>
