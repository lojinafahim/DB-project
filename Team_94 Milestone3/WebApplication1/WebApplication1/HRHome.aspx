<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRHome.aspx.cs" 
    Inherits="WebApplication1.HRHome" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #5D8AA8 0%, #7A9EB1 50%, #98AFC7 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            padding: 30px;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #2ecc71;
        }

        .header-left h1 {
            color: #2c3e50;
            margin: 0;
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-left h1:before {
            content: "🏢";
            font-size: 24px;
        }

        .welcome-label {
            color: #7f8c8d;
            font-size: 16px;
            margin-top: 5px;
        }

        .logout-btn {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.2);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.3);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .dashboard-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 25px;
            border-left: 5px solid #2ecc71;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            background: white;
        }

        .card-icon {
            font-size: 36px;
            margin-bottom: 15px;
            color: #2ecc71;
        }

        .card-title {
            color: #2c3e50;
            font-size: 20px;
            margin-top: 0;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-description {
            color: #7f8c8d;
            font-size: 14px;
            line-height: 1.5;
        }

        /* Deductions Section */
        .deductions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .deduction-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }

        .deduction-card:hover {
            border-color: #2ecc71;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.1);
        }

        .form-group {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            min-width: 120px;
        }

        .form-input {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            min-width: 200px;
            flex-grow: 1;
        }

        .form-input:focus {
            border-color: #2ecc71;
            outline: none;
            box-shadow: 0 0 5px rgba(46, 204, 113, 0.3);
        }
        /* Success message styling - Green */
.success-message {
    color: #27ae60;
    background-color: rgba(46, 204, 113, 0.1);
    border: 1px solid rgba(46, 204, 113, 0.2);
}

/* Error message styling - Red */
.error-message {
    color: #e74c3c;
    background-color: rgba(231, 76, 60, 0.1);
    border: 1px solid rgba(231, 76, 60, 0.2);
}

        .submit-btn {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(46, 204, 113, 0.2);
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #27ae60, #219653);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 204, 113, 0.3);
        }

        /* Payroll Section */
        .payroll-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            padding: 25px;
            border-radius: 12px;
            border: 2px solid #2ecc71;
            margin-top: 30px;
        }

        .payroll-title {
            color: #2c3e50;
            font-size: 20px;
            margin-top: 0;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .payroll-title:before {
            content: "💰";
            font-size: 18px;
        }

        /* Error label - matches login page style */
        .error-label {
            color: #e74c3c; /* Red color for errors */
            margin-top: 10px;
            display: block; /* Always visible to reserve space */
            min-height: 20px; /* Minimum height to reserve space */
            font-size: 14px;
            font-weight: bold;
            padding: 10px;
            border-radius: 5px;
            background-color: white; /* White background by default */
            border: 1px solid transparent; /* Transparent border by default */
            visibility: visible; /* Always visible to reserve space */
            opacity: 1; /* Fully visible */
        }

        /* When error label is empty, make it invisible but still take space */
        .error-label:empty {
            color: transparent;
            background-color: white;
            border-color: transparent;
        }

        /* When error label has content, show the error styling */
        .error-label:not(:empty) {
            background-color: rgba(231, 76, 60, 0.1); /* Light pink background for errors */
            border: 1px solid rgba(231, 76, 60, 0.2); /* Light red border for errors */
        }

        .section-hr {
            border: none;
            height: 1px;
            background: linear-gradient(to right, transparent, #ddd, transparent);
            margin: 30px 0;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }
            
            .header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .form-input {
                width: 100%;
                min-width: unset;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
        
        html {
            scroll-behavior: smooth;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Header Section -->
            <div class="header-section">
                <div class="header-left">
                    <h1>HR Dashboard</h1>
                    <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-label" Text="" />
                </div>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                    OnClick="btnLogout_Click" CssClass="logout-btn" />
            </div>

            <!-- Main Dashboard Grid -->
            <div class="dashboard-grid">
                <!-- Pending Annual & Accidental Leaves -->
                <a href="HRAnnualAccidentalLeaves.aspx" class="dashboard-card">
                    <div class="card-icon">📋</div>
                    <h3 class="card-title">Pending Annual & Accidental Leaves</h3>
                    <p class="card-description">Approve or reject annual and accidental leave requests submitted by employees.</p>
                </a>

                <!-- Pending Unpaid Leaves -->
                <a href="HRUnpaidLeaves.aspx" class="dashboard-card">
                    <div class="card-icon">📅</div>
                    <h3 class="card-title">Pending Unpaid Leaves</h3>
                    <p class="card-description">Review and process unpaid leave requests from employees.</p>
                </a>

                <!-- Pending Compensation Leaves -->
                <a href="HRCompensationLeaves.aspx" class="dashboard-card">
                    <div class="card-icon">⚖️</div>
                    <h3 class="card-title">Pending Compensation Leaves</h3>
                    <p class="card-description">Manage compensation leave requests and approvals.</p>
                </a>
            </div>

            <div class="section-hr"></div>

            <!-- Add Deductions Section -->
            <div>
                <h3 style="color: #2c3e50; margin-bottom: 20px;">Add Deductions</h3>
                <div class="deductions-grid">
                    <!-- Missing Hours Deduction -->
                    <div class="deduction-card">
                        <h4 style="color: #2c3e50; margin-top: 0; margin-bottom: 15px;">Missing Hours Deduction</h4>
                        <div class="form-group">
                            <span class="form-label">Employee ID:</span>
                            <asp:TextBox ID="txtDeductHoursEmp" runat="server" CssClass="form-input" placeholder="Enter Employee ID" />
                        </div>
                        <div class="form-group">
                            <span class="form-label">Missing Hours:</span>
                            <asp:TextBox ID="txtDeductHours" runat="server" CssClass="form-input" placeholder="Enter hours" />
                        </div>
                        <asp:Button ID="btnAddHoursDed" runat="server" Text="Add Deduction" 
                            OnClick="btnAddHoursDed_Click" CssClass="submit-btn" />
                        <asp:Label ID="lblHoursError" runat="server" CssClass="error-label"></asp:Label>
                    </div>

                    <!-- Missing Days Deduction -->
                    <div class="deduction-card">
                        <h4 style="color: #2c3e50; margin-top: 0; margin-bottom: 15px;">Missing Days Deduction</h4>
                        <div class="form-group">
                            <span class="form-label">Employee ID:</span>
                            <asp:TextBox ID="txtDeductDaysEmp" runat="server" CssClass="form-input" placeholder="Enter Employee ID" />
                        </div>
                        <div class="form-group">
                            <span class="form-label">Missing Days:</span>
                            <asp:TextBox ID="txtDeductDays" runat="server" CssClass="form-input" placeholder="Enter days" />
                        </div>
                        <asp:Button ID="btnAddDaysDed" runat="server" Text="Add Deduction" 
                            OnClick="btnAddDaysDed_Click" CssClass="submit-btn" />
                        <asp:Label ID="lblDaysError" runat="server" CssClass="error-label"></asp:Label>
                    </div>

                    <!-- Unpaid Leave Deduction -->
                    <div class="deduction-card">
                        <h4 style="color: #2c3e50; margin-top: 0; margin-bottom: 15px;">Unpaid Leave Deduction</h4>
                        <div class="form-group"> <div class="form-group" style="margin-bottom: 53px;">
                            <span class="form-label">Leave Request ID:</span>
                            <asp:TextBox ID="txtUnpaidLeaveID" runat="server" CssClass="form-input" placeholder="Enter Leave Request ID" />
                        </div>
                        <asp:Button ID="btnAddUnpaidDed" runat="server" Text="Add Unpaid Deduction" 
                            OnClick="btnAddUnpaidDed_Click" CssClass="submit-btn" />
                        <asp:Label ID="lblUnpaidError" runat="server" CssClass="error-label"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="section-hr"></div>

            <!-- Generate Payroll Section -->
            <div class="payroll-section">
                <h3 class="payroll-title">Generate Monthly Payroll</h3>
                <div class="form-group">
                    <span class="form-label">Year:</span>
                    <asp:TextBox ID="txtPayrollYear" runat="server" CssClass="form-input" Width="100px" placeholder="YYYY" />
                    <span class="form-label">Month:</span>
                    <asp:TextBox ID="txtPayrollMonth" runat="server" CssClass="form-input" Width="80px" placeholder="MM" />
                    <asp:Button ID="btnGeneratePayroll" runat="server" Text="Generate All Payrolls" 
                        OnClick="btnGeneratePayroll_Click" CssClass="submit-btn" 
                        Style="background: linear-gradient(135deg, #9b59b6, #8e44ad); max-width: 200px;" />
                </div>
                <asp:Label ID="lblPayrollError" runat="server" CssClass="error-label"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>