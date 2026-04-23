<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payroll.aspx.cs" Inherits="WebApplication1.Payroll" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Last Month's Payroll</title>
    <style>
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: white; }

        .sidebar {
            height: 100vh;
            width: 240px;
            background: linear-gradient(180deg, #5D8AA8 0%, #7A9EB1 100%);
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 25px;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            border-right: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 14px 22px;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            margin: 3px 0;
        }

        .sidebar-link {
            display: block;
            color: white;
            padding: 14px 22px;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            margin: 3px 0;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .sidebar a:hover, .sidebar-link:hover {
            background-color: rgba(255,255,255,0.15);
            border-left: 3px solid #3498db;
            padding-left: 25px;
        }

        #lblEmpIDSidebar {
            color: white;
            font-weight: 600;
            font-size: 22px;
            display: block;
            margin-bottom: 25px;
            padding: 0 22px 15px 22px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            letter-spacing: 0.5px;
        }

        .content {
            margin-left: 240px;
            padding: 20px;
            min-height: 100vh;
            background-color: white;
        }

        .header {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 20px;
        }

        .header-title {
            font-size: 24px;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
            margin-right: auto;
        }

        .btn-home, .btn-logout {
            width: 40px;
            height: 40px;
            cursor: pointer;
            margin-left: 10px;
        }

        .section { 
            margin-top: 20px; 
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            border: 1px solid rgba(0,0,0,0.08);
        }
        
        /* Instruction text */
        .instruction-text {
            color: #5D6D7E;
            font-size: 14px;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 6px;
            border-left: 4px solid #5D8AA8;
            font-style: normal;
            font-weight: 500;
        }
        
        .gridview { 
            border-collapse: collapse;
            width: 100%;
            margin-top: 15px;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .gridview th, .gridview td { 
            border: 1px solid #e0e0e0;
            padding: 12px 15px;
            text-align: left;
            font-size: 14px;
        }
        
        /* Table header matches sidebar gradient */
        .gridview th { 
            background: linear-gradient(180deg, #5D8AA8 0%, #7A9EB1 100%);
            color: white;
            font-weight: 600;
            border-color: #5D8AA8;
        }
        
        .gridview tr:nth-child(even) { 
            background-color: #f8f9fa;
        }
        
        .gridview tr:nth-child(odd) { 
            background-color: #ffffff;
        }
        
        .gridview tr:hover {
            background-color: #e8f4fc;
        }
        
        /* Empty message - hidden when empty */
        .empty-message { 
            color: #7f8c8d;
            font-style: italic;
            margin-top: 10px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #95a5a6;
            display: none; /* Hidden by default */
            text-align: center;
            font-size: 15px;
        }
        
        /* Show empty message only when it has content */
        .empty-message:not(:empty) {
            display: block;
        }
        
        hr {
            border: 0;
            height: 1px;
            background-color: #e0e0e0;
            margin: 15px 0;
        }
        
        /* Highlight important payroll numbers */
        .salary-amount {
            font-weight: 600;
            color: #27ae60; /* Green for money amounts */
        }
        
        .deduction-amount {
            font-weight: 600;
            color: #e74c3c; /* Red for deductions */
        }
        
        .net-salary {
            font-weight: 700;
            color: #2c3e50; /* Dark for net salary */
            background-color: #f8f9fa;
            border-top: 2px solid #5D8AA8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <asp:Label ID="lblEmpIDSidebar" runat="server" Text="Quick Actions"></asp:Label>
            <a href='Performance.aspx?empId=<%= ViewState["empId"] %>'>My Performance</a>
            <a href='Attendance.aspx?empId=<%= ViewState["empId"] %>'>My Attendance</a>
            <a href='Payroll.aspx?empId=<%= ViewState["empId"] %>'>Last Month Payroll</a>
            <a href='Deductions.aspx?empId=<%= ViewState["empId"] %>'>Deductions</a>
            <a href='AnnualLeave.aspx?empId=<%= ViewState["empId"] %>'>Apply Annual Leave</a>
            <a href='LeaveStatus.aspx?empId=<%= ViewState["empId"] %>'>Leaves' Status</a>
            <!-- FIXED: Changed to LinkButton for server-side click -->
            <asp:LinkButton ID="lnkOtherActions" runat="server" OnClick="btnOtherActions_Click" 
                CssClass="sidebar-link">Other Actions</asp:LinkButton>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Header -->
            <div class="header">
                <h2 class="header-title">Last Month's Payroll</h2>
                <asp:ImageButton ID="btnHome" runat="server" ImageUrl="Images/house icon.png" CssClass="btn-home" OnClick="btnHome_Click" />
                <asp:ImageButton ID="btnLogout" runat="server" ImageUrl="Images/logout icon.png" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
            <hr />

            <div class="section">
                <!-- Instruction text -->
                <div class="instruction-text">
                    Your payroll details for the previous month are displayed below.
                </div>

                <!-- Empty message - will only appear when it has content -->
                <asp:Label ID="lblPayrollEmpty" runat="server" CssClass="empty-message"></asp:Label>

                <asp:GridView ID="gvPayroll" runat="server" CssClass="gridview" AutoGenerateColumns="true"
                    OnRowDataBound="gvPayroll_RowDataBound">
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>