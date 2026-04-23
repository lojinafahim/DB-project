<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnnualLeave.aspx.cs" Inherits="WebApplication1.AnnualLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Annual Leave</title>
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

        .sidebar a:hover {
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
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
            font-style: italic;
        }
        
        .input-area { 
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #e9ecef;
        }
        
        input[type=text] { 
            padding: 10px 12px;
            width: 200px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        input[type=text]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }
        
        .btn { 
            padding: 10px 20px;
            background: linear-gradient(135deg, #5D8AA8, #7A9EB1);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s;
            box-shadow: 0 3px 8px rgba(93, 138, 168, 0.2);
        }
        
        .btn:hover {
            background: linear-gradient(135deg, #4a7594, #6a8fa1);
            transform: translateY(-2px);
            box-shadow: 0 5px 12px rgba(93, 138, 168, 0.3);
        }
        
        /* Status message */
        .status-label { 
            color: #7f8c8d;
            margin-top: 15px;
            padding: 12px;
            border-radius: 6px;
            border-left: 4px solid #95a5a6;
            background-color: #f8f9fa;
            display: none; /* Hidden by default */
        }
        
        /* Success message */
        .status-label.success {
            color: #27ae60;
            border-left-color: #27ae60;
            background-color: rgba(39, 174, 96, 0.1);
        }
        
        /* Error message */
        .status-label.error {
            color: #e74c3c;
            border-left-color: #e74c3c;
            background-color: rgba(231, 76, 60, 0.1);
        }
        
        /* Show status label only when it has content */
        .status-label:not(:empty) {
            display: block;
        }
        
        hr {
            border: 0;
            height: 1px;
            background-color: #e0e0e0;
            margin: 15px 0;
        }
        
        /* Input hints */
        .input-hint {
            font-size: 12px;
            color: #95a5a6;
            margin-top: 5px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <asp:Label ID="lblEmpIDSidebar" runat="server" Text="Quick Actions"></asp:Label>
            <a href='Performance.aspx?empId=<%= Request.QueryString["empId"] %>'>My Performance</a>
            <a href='Attendance.aspx?empId=<%= Request.QueryString["empId"] %>'>My Attendance</a>
            <a href='Payroll.aspx?empId=<%= Request.QueryString["empId"] %>'>Last Month Payroll</a>
            <a href='Deductions.aspx?empId=<%= Request.QueryString["empId"] %>'>Deductions</a>
            <a href='AnnualLeave.aspx?empId=<%= Request.QueryString["empId"] %>'>Apply Annual Leave</a>
            <a href='LeaveStatus.aspx?empId=<%= Request.QueryString["empId"] %>'>Leaves' Status</a>
           <asp:LinkButton ID="lnkOtherActions" runat="server" OnClick="btnOtherActions_Click" 
    CssClass="sidebar-link">Other Actions</asp:LinkButton>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="header">
                <h2 class="header-title">Apply for Annual Leave</h2>
                <asp:ImageButton ID="btnHome" runat="server" ImageUrl="Images/house icon.png" CssClass="btn-home" OnClick="btnHome_Click" />
                <asp:ImageButton ID="btnLogout" runat="server" ImageUrl="Images/logout icon.png" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
            <hr />

            <div class="section">
                <!-- Instruction text -->
                <div class="instruction-text">
                    Fill in the details below to apply for annual leave.
                </div>

                <div class="input-area">
                    <asp:TextBox ID="txtReplacementEmp" runat="server" Placeholder="Replacement Employee ID"></asp:TextBox>
                    <div class="input-hint">Enter the ID of the employee who will cover your duties</div>
                    
                    <asp:TextBox ID="txtStartDate" runat="server" Placeholder="Start Date (yyyy-mm-dd)"></asp:TextBox>
                    <div class="input-hint">Format: YYYY-MM-DD (e.g., 2024-12-25)</div>
                    
                    <asp:TextBox ID="txtEndDate" runat="server" Placeholder="End Date (yyyy-mm-dd)"></asp:TextBox>
                    <div class="input-hint">Format: YYYY-MM-DD (e.g., 2024-12-31)</div>
                    
                    <br />
                    <asp:Button ID="btnSubmitLeave" runat="server" Text="GO" CssClass="btn" OnClick="btnSubmitLeave_Click" />
                </div>

                <asp:Label ID="lblLeaveStatus" runat="server" CssClass="status-label"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>