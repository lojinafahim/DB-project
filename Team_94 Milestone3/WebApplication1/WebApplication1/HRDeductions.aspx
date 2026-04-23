<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRDeductions.aspx.cs" Inherits="WebApplication1.HRDeductions" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Deductions</title>
    <style>
        body{font-family:'Segoe UI',Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(135deg,#5D8AA8 0%,#7A9EB1 50%,#98AFC7 100%);margin:0;padding:20px}
        .dashboard-container{max-width:1100px;margin:20px auto;padding:20px;background:#fff;border-radius:8px;box-shadow:0 6px 18px rgba(0,0,0,0.08)}
        .header-section{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px}
        .deduction-form{background:#fff;padding:15px;border-radius:8px;margin-bottom:15px;border:1px solid #e0e0e0}
        .form-group{display:flex;align-items:center;gap:10px;flex-wrap:wrap}
        .form-label{font-weight:600;color:#2c3e50;min-width:120px}
        .form-input{padding:10px 12px;border:1px solid #ddd;border-radius:8px}
        .submit-btn{background:linear-gradient(135deg,#2ecc71,#27ae60);color:#fff;padding:10px 16px;border-radius:8px;border:none;cursor:pointer}
        .status-label{display:inline-block;margin-top:12px;color:#2c3e50;font-weight:600}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <div class="header-section">
                <div>
                    <h2>Add Deductions</h2>
                    <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-label" />
                </div>
                <div>
                    <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="action-button" />
                    &nbsp;
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="action-button" />
                </div>
            </div>

            <div class="deduction-form">
                <h4>Missing Hours Deduction</h4>
                <div class="form-group">
                    <span class="form-label">Employee ID:</span>
                    <asp:TextBox ID="txtDeductHoursEmp" runat="server" CssClass="form-input" />
                    <span class="form-label">Missing Hours:</span>
                    <asp:TextBox ID="txtDeductHours" runat="server" CssClass="form-input" />
                    <asp:Button ID="btnAddHoursDed" runat="server" Text="Add Deduction" OnClick="btnAddHoursDed_Click" CssClass="submit-btn" />
                </div>
            </div>

            <div class="deduction-form">
                <h4>Missing Days Deduction</h4>
                <div class="form-group">
                    <span class="form-label">Employee ID:</span>
                    <asp:TextBox ID="txtDeductDaysEmp" runat="server" CssClass="form-input" />
                    <span class="form-label">Missing Days:</span>
                    <asp:TextBox ID="txtDeductDays" runat="server" CssClass="form-input" />
                    <asp:Button ID="btnAddDaysDed" runat="server" Text="Add Deduction" OnClick="btnAddDaysDed_Click" CssClass="submit-btn" />
                </div>
            </div>

            <div class="deduction-form">
                <h4>Unpaid Leave Deduction</h4>
                <div class="form-group">
                    <span class="form-label">Leave Request ID:</span>
                    <asp:TextBox ID="txtUnpaidLeaveID" runat="server" CssClass="form-input" />
                    <asp:Button ID="btnAddUnpaidDed" runat="server" Text="Add Unpaid Deduction" OnClick="btnAddUnpaidDed_Click" CssClass="submit-btn" />
                </div>
            </div>

            <asp:Label ID="lblStatus" runat="server" CssClass="status-label" />
        </div>
    </form>
</body>
</html>
