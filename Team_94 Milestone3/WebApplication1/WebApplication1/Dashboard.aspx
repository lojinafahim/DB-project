<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication1.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Dashboard</title>
    <style>
        body { 
            margin: 0; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: white; /* White background for entire page */
        }

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
            background-color: white; /* White background for right side */
        }

        .header {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        /* SQUARE BUTTONS */
        .btn-home, .btn-logout {
            width: 40px;
            height: 40px;
            cursor: pointer;
            margin-left: 10px;
        }

        .welcome-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 20px;
            background: white;
            padding: 35px; /* Increased padding for better spacing */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 5px 20px rgba(0,0,0,0.1); /* Shadow outlining the box */
            border: 1px solid rgba(0,0,0,0.08); /* Subtle border */
        }

        .welcome-text h1 {
            color: #333;
            font-size: 100px;
            margin: 0 0 3px 0;
            line-height: 1.2;
        }

        .welcome-text h2 {
            color: #333;
            font-size: 42px;
            margin: 0 0 90px 0;
            line-height: 1.2;
        }

        .welcome-text p {
            margin: 0;
            font-size: 20px;
            color: #555; /* Slightly darker for better readability */
        }

        #dashboardImage {
            width: 800px;
            height: auto;
            transform: translateY(20px);
            border-radius: 4px; /* Slight rounding for image */
        }

        hr {
            border: 0;
            height: 1px;
            background-color: #e0e0e0; /* Lighter grey line */
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <asp:Label ID="lblEmpIDSidebar" runat="server" Text=""></asp:Label>
            <a href='Performance.aspx?empId=<%= Request.QueryString["empId"] %>'>My Performance</a>
            <a href='Attendance.aspx?empId=<%= Request.QueryString["empId"] %>'>My Attendance</a>
            <a href='Payroll.aspx?empId=<%= Request.QueryString["empId"] %>'>Last Month Payroll</a>
            <a href='Deductions.aspx?empId=<%= Request.QueryString["empId"] %>'>Deductions</a>
            <a href='AnnualLeave.aspx?empId=<%= Request.QueryString["empId"] %>'>Apply Annual Leave</a>
            <a href='LeaveStatus.aspx?empId=<%= Request.QueryString["empId"] %>'>Leaves' Status</a>
            <!-- Changed to LinkButton for server-side click -->
            <asp:LinkButton ID="lnkOtherActions" runat="server" OnClick="btnOtherActions_Click" 
                CssClass="sidebar-link">Other Actions</asp:LinkButton>
        </div>

        <div class="content">
            <div class="header">
                <asp:ImageButton ID="btnLogout" runat="server" ImageUrl="Images/logout icon.png" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>

            <hr />

            <div class="welcome-section">
                <div class="welcome-text">
                    <h1>Welcome</h1>
                    <h2><asp:Label ID="lblEmployeeName" runat="server" Text=""></asp:Label></h2>
                    <p>Select from Quick Actions's section</p>
                    <p>which action you want to perform or view.</p>
                </div>
                <img src="Images/employee.png" alt="Dashboard Image" id="dashboardImage" />
            </div>
        </div>
    </form>
</body>
</html>