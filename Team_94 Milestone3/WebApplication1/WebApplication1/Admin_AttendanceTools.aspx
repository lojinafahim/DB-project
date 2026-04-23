<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_AttendanceTools.aspx.cs" Inherits="WebApplication1.Admin_AttendanceTools" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance Tools</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --border: #e9ecef;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --card-bg: #f8f9fa;
            --hover-bg: white;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: var(--text-dark);
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, var(--admin-color), var(--admin-light));
            color: white;
            padding: 1.75rem 2.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.75rem;
            font-weight: 600;
        }

        .page-title i {
            background: rgba(255, 255, 255, 0.2);
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .back-btn {
            color: white;
            text-decoration: none;
            background: rgba(255, 255, 255, 0.15);
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-1px);
        }

        .logout-btn {
            color: white;
            text-decoration: none;
            background: rgba(255, 255, 255, 0.15);
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-1px);
        }

        .content {
            padding: 2.5rem;
        }

        /* Simplified Grid Layout */
        .tools-section {
            margin-bottom: 2.5rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--admin-color);
        }

        .tools-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .tool-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .tool-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            background: var(--hover-bg);
            border-color: var(--admin-light);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
        }

        .card-icon {
            width: 40px;
            height: 40px;
            background: rgba(231, 76, 60, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--admin-color);
            font-size: 1.25rem;
        }

        .card-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-dark);
            margin: 0;
        }

        .card-description {
            color: var(--text-light);
            font-size: 0.875rem;
            line-height: 1.5;
            margin-bottom: 1.25rem;
            min-height: 42px;
        }

        /* Form Inputs */
        .input-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .input-label {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--text-dark);
            min-width: 100px;
        }

        .input-field {
            flex: 1;
            min-width: 180px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.875rem;
            font-family: inherit;
            transition: all 0.3s ease;
        }

        .input-field:focus {
            outline: none;
            border-color: var(--admin-color);
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
        }

        .tool-button {
            background: linear-gradient(135deg, var(--admin-color), var(--admin-light));
            color: white;
            border: none;
            padding: 0.875rem 1.5rem;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .tool-button:hover {
            background: linear-gradient(135deg, #c0392b, #e74c3c);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.25);
        }

        /* Additional Tools Section */
        .additional-tools {
            margin-top: 2rem;
        }

        .additional-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
        }

        /* Results Section */
        .results-section {
            margin-top: 2.5rem;
        }

        .results-container {
            background: white;
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            margin-top: 1rem;
        }

        .gridview-container {
            overflow-x: auto;
        }

        .gridview-container table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        .gridview-container th {
            background: var(--card-bg);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.875rem;
            border-bottom: 2px solid var(--border);
        }

        .gridview-container td {
            padding: 0.875rem 1rem;
            border-bottom: 1px solid var(--border);
            color: var(--text-dark);
            font-size: 0.875rem;
        }

        .gridview-container tr:hover {
            background-color: rgba(231, 76, 60, 0.05);
        }

        /* Messages */
        .messages-section {
            margin-top: 2rem;
        }

        .message-box {
            padding: 1.25rem;
            border-radius: 10px;
            font-weight: 500;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.95rem;
        }

        .message-box:empty {
            display: none;
        }

        .message-box.success {
            background: rgba(39, 174, 96, 0.1);
            border: 1px solid rgba(39, 174, 96, 0.2);
            color: var(--success-color);
        }

        .message-box.status {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.2);
            color: #3498db;
        }

        .message-box i {
            font-size: 1.25rem;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .additional-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                max-width: 95%;
            }
            
            .content {
                padding: 1.75rem;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .tools-grid,
            .additional-grid {
                grid-template-columns: 1fr;
                gap: 1.25rem;
            }
            
            .input-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .input-field {
                width: 100%;
                min-width: unset;
            }
            
            .input-label {
                min-width: auto;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .page-title i {
                width: 40px;
                height: 40px;
                font-size: 1.25rem;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .back-btn, .logout-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 15px;
            }
            
            .container {
                max-width: 100%;
                border-radius: 12px;
            }
            
            .header {
                padding: 1.25rem;
            }
            
            .content {
                padding: 1.5rem;
            }
            
            .tool-card {
                padding: 1.25rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <div class="header-content">
                    <h1 class="page-title">
                        <i class="fas fa-tools"></i>
                        Attendance Tools
                    </h1>
                    <div class="header-actions">
                        <asp:Button ID="btnBackDashboard" runat="server"
                            Text="← Back to Dashboard"
                            OnClick="btnBackDashboard_Click"
                            CssClass="back-btn" />
                        <a href="Home.aspx?logout=true" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="content">
                <!-- Main Tools Section -->
                <div class="tools-section">
                    <h2 class="section-title">
                        <i class="fas fa-tasks"></i>
                        Quick Actions
                    </h2>
                    
                    <div class="tools-grid">
                        <!-- Yesterday's Attendance -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-calendar-day"></i>
                                </div>
                                <h3 class="card-title">Yesterday's Attendance</h3>
                            </div>
                            <p class="card-description">
                                Retrieve attendance records for all employees from yesterday.
                            </p>
                            <asp:Button ID="btnGetYesterday" runat="server"
                                Text="Get Yesterday Attendance"
                                OnClick="btnGetYesterday_Click"
                                CssClass="tool-button" />
                        </div>

                        <!-- Winter Performance -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-snowflake"></i>
                                </div>
                                <h3 class="card-title">Winter Performance</h3>
                            </div>
                            <p class="card-description">
                                Analyze attendance performance during winter months (Dec/Jan/Feb).
                            </p>
                            <asp:Button ID="btnGetWinter" runat="server"
                                Text="Get Winter Performance"
                                OnClick="btnGetWinter_Click"
                                CssClass="tool-button" />
                        </div>

                        <!-- Remove Holiday Attendance -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-calendar-times"></i>
                                </div>
                                <h3 class="card-title">Remove Holiday Attendance</h3>
                            </div>
                            <p class="card-description">
                                Remove attendance records that were logged on official holidays.
                            </p>
                            <asp:Button ID="btnRemoveHolidays" runat="server"
                                Text="Remove Holiday Attendance"
                                OnClick="btnRemoveHolidays_Click"
                                CssClass="tool-button" />
                        </div>

                        <!-- Update Employment Status -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-sync-alt"></i>
                                </div>
                                <h3 class="card-title">Update Employment Status</h3>
                            </div>
                            <p class="card-description">
                                Update employment status for all employees based on current records.
                            </p>
                            <asp:Button ID="btnUpdateEmployment" runat="server"
                                Text="Update Employment Status"
                                OnClick="btnUpdateEmployment_Click"
                                CssClass="tool-button" />
                        </div>
                    </div>
                </div>

                <!-- Additional Tools Section -->
                <div class="additional-tools">
                    <h2 class="section-title">
                        <i class="fas fa-cog"></i>
                        Advanced Tools
                    </h2>
                    
                    <div class="additional-grid">
                        <!-- Remove Unattended DayOff -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-user-slash"></i>
                                </div>
                                <h3 class="card-title">Remove Unattended DayOff</h3>
                            </div>
                            <p class="card-description">
                                Remove unattended official day off records for current month.
                            </p>
                            <div class="input-row">
                                <span class="input-label">Employee ID:</span>
                                <asp:TextBox ID="txtUnattendedEmp" runat="server" 
                                    CssClass="input-field" 
                                    placeholder="Enter ID" />
                            </div>
                            <asp:Button ID="btnRemoveUnattended" runat="server"
                                Text="Remove DayOff"
                                OnClick="btnRemoveUnattended_Click"
                                CssClass="tool-button" />
                        </div>

                        <!-- Remove Approved Leaves -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-file-signature"></i>
                                </div>
                                <h3 class="card-title">Remove Approved Leaves</h3>
                            </div>
                            <p class="card-description">
                                Remove attendance rows for approved leave days.
                            </p>
                            <div class="input-row">
                                <span class="input-label">Employee ID:</span>
                                <asp:TextBox ID="txtApprovedLeavesEmp" runat="server" 
                                    CssClass="input-field" 
                                    placeholder="Enter ID" />
                            </div>
                            <asp:Button ID="btnRemoveApprovedLeaves" runat="server"
                                Text="Remove Leaves"
                                OnClick="btnRemoveApprovedLeaves_Click"
                                CssClass="tool-button" />
                        </div>

                        <!-- Replace Employee -->
                        <div class="tool-card">
                            <div class="card-header">
                                <div class="card-icon">
                                    <i class="fas fa-exchange-alt"></i>
                                </div>
                                <h3 class="card-title">Replace Employee</h3>
                            </div>
                            <p class="card-description">
                                Transfer attendance records from one employee to another.
                            </p>
                            <div class="input-row">
                                <span class="input-label">From ID:</span>
                                <asp:TextBox ID="txtReplaceFrom" runat="server" 
                                    CssClass="input-field" 
                                    placeholder="From Employee ID" />
                            </div>
                            <div class="input-row">
                                <span class="input-label">To ID:</span>
                                <asp:TextBox ID="txtReplaceTo" runat="server" 
                                    CssClass="input-field" 
                                    placeholder="To Employee ID" />
                            </div>
                            <div class="input-row">
                                <span class="input-label">Date:</span>
                                <asp:TextBox ID="txtReplaceDate" runat="server" 
                                    CssClass="input-field" 
                                    placeholder="YYYY-MM-DD (optional)" />
                            </div>
                            <asp:Button ID="btnReplaceEmployee" runat="server"
                                Text="Replace Employee"
                                OnClick="btnReplaceEmployee_Click"
                                CssClass="tool-button" />
                        </div>
                    </div>
                </div>

                <!-- Results Section -->
                <div class="results-section">
                    <h2 class="section-title">
                        <i class="fas fa-table"></i>
                        Results
                    </h2>
                    
                    <div class="results-container">
                        <div class="gridview-container">
                            <asp:GridView ID="gvResults" runat="server"
                                AutoGenerateColumns="true"
                                EmptyDataText="No records found. Run a tool to see results."
                                HeaderStyle-CssClass="gridview-header"
                                RowStyle-CssClass="gridview-row"
                                AlternatingRowStyle-CssClass="gridview-altrow" />
                        </div>
                    </div>
                </div>

                <!-- Messages Section -->
                <div class="messages-section">
                    <asp:Label ID="lblMessage" runat="server" 
                        CssClass="message-box success" />
                    <asp:Label ID="lblStatus" runat="server" 
                        CssClass="message-box status" />
                </div>
            </div>
        </div>
    </form>

    <script>
        // Enhance form interactions
        document.addEventListener('DOMContentLoaded', function () {
            // Add focus styles to all form inputs
            const inputs = document.querySelectorAll('.input-field');
            inputs.forEach(input => {
                input.addEventListener('focus', function () {
                    this.parentElement.parentElement.style.transform = 'translateY(-1px)';
                });

                input.addEventListener('blur', function () {
                    this.parentElement.parentElement.style.transform = 'translateY(0)';
                });
            });

            // Auto-hide messages after 8 seconds if they exist
            setTimeout(function () {
                const messages = document.querySelectorAll('.message-box');
                messages.forEach(msg => {
                    if (msg.textContent.trim() !== '') {
                        msg.style.opacity = '0';
                        msg.style.transition = 'opacity 0.5s ease';
                        setTimeout(() => {
                            msg.style.display = 'none';
                        }, 500);
                    }
                });
            }, 8000);
        });
    </script>
</body>
</html>