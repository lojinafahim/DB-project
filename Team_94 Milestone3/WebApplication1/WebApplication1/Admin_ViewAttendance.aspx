<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_ViewAttendance.aspx.cs" Inherits="WebApplication1.Admin_ViewAttendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Attendance (After Admin Changes)</title>
    <style>
        .wrapper { width: 900px; margin: 20px auto; font-family: Segoe UI, Arial, sans-serif; }
        .section { margin: 12px 0; padding: 8px; border: 1px solid #ddd; border-radius: 6px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
                <h2 style="margin:0;">Attendance Overview</h2>
                <asp:Button ID="btnBackTools" runat="server"
                    Text="← Back to Attendance Tools"
                    OnClick="btnBackTools_Click" />
            </div>

            <div class="section">
                <asp:Label ID="lblInfo" runat="server" ForeColor="Blue" />
            </div>

            <div class="section">
                <asp:GridView ID="gvAttendance" runat="server"
                    AutoGenerateColumns="true"
                    EmptyDataText="No attendance records found."
                    Width="100%" />
            </div>
        </div>
    </form>
</body>
</html>
