<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="WebApplication1.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --dark-bg: #1a1a2e;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            --shadow-hover: 0 15px 40px rgba(231, 76, 60, 0.15);
            --border: #f0f0f0;
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
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        .header {
            background: white;
            padding: 1.5rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid var(--border);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--admin-color), var(--admin-light));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .brand-text h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            line-height: 1.2;
        }

        .brand-text p {
            font-size: 0.875rem;
            color: var(--text-light);
            margin-top: 2px;
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(231, 76, 60, 0.1);
            color: var(--admin-color);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Simple Text Logout Link */
        .logout-link {
            color: var(--admin-color);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #c0392b;
        }

        /* Main Content */
        .main-content {
            padding: 3rem 0;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--admin-color), var(--admin-light));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-subtitle {
            color: var(--text-light);
            font-size: 1rem;
            margin-bottom: 2.5rem;
            max-width: 600px;
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 1.75rem;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s ease;
            border: 1px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
            border-color: var(--admin-light);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--admin-color), var(--admin-light));
        }

        .card-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--admin-light), var(--admin-color));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.25rem;
            color: white;
            font-size: 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }

        .card-desc {
            color: var(--text-light);
            font-size: 0.9375rem;
            line-height: 1.5;
        }

        /* Footer */
        .footer {
            margin-top: 4rem;
            padding: 2rem 0;
            border-top: 1px solid var(--border);
            text-align: center;
            color: var(--text-light);
            font-size: 0.875rem;
        }

        .footer p {
            margin: 0.25rem 0;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(39, 174, 96, 0.1);
            color: #27ae60;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
            margin-left: 8px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 0 16px;
            }
            
            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .user-controls {
                width: 100%;
                justify-content: space-between;
            }
            
            .cards-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title {
                font-size: 1.75rem;
            }
        }

        @media (max-width: 480px) {
            .brand {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .user-badge {
                padding: 6px 12px;
                font-size: 0.8125rem;
            }
            
            .logout-link {
                padding: 6px 12px;
                font-size: 0.8125rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <header class="header">
            <div class="container">
                <div class="header-content">
                    <div class="brand">
                        <div class="brand-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="brand-text">
                            <h1>Admin Panel</h1>
                            <p>System Administration</p>
                        </div>
                    </div>
                    
                    <div class="user-controls">
                        <div class="user-badge">
                            <i class="fas fa-user-shield"></i>
                            <span>Administrator</span>
                        </div>
                        <a href="Home.aspx?logout=true" class="logout-link">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <div class="container">
                <div class="page-header">
                    <h1 class="page-title">System Controls</h1>
                    <p class="page-subtitle">Manage administrative functions and system operations</p>
                </div>

                <div class="cards-grid">
                    <!-- Employee Profiles -->
                    <asp:LinkButton ID="btnViewProfiles" runat="server" 
                        CssClass="card" OnClick="btnViewProfiles_Click">
                        <div class="card-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="card-title">Employee Profiles</h3>
                        <p class="card-desc">Manage employee records and information</p>
                    </asp:LinkButton>

                    <!-- Department Analytics -->
                    <asp:LinkButton ID="btnEmployeesPerDept" runat="server" 
                        CssClass="card" OnClick="btnEmployeesPerDept_Click">
                        <div class="card-icon">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <h3 class="card-title">Department Analytics</h3>
                        <p class="card-desc">View number of employees in each department</p>
                    </asp:LinkButton>

                    <!-- Medical Leaves -->
                    <asp:LinkButton ID="btnRejectedMedical" runat="server" 
                        CssClass="card" OnClick="btnRejectedMedical_Click">
                        <div class="card-icon">
                            <i class="fas fa-file-medical"></i>
                        </div>
                        <h3 class="card-title">Medical Leaves</h3>
                        <p class="card-desc">Review rejected medical leave requests</p>
                    </asp:LinkButton>

                    <!-- Deductions (Changed to dollar sign) -->
                    <asp:LinkButton ID="btnRemoveDeductions" runat="server" 
                        CssClass="card" OnClick="btnRemoveDeductions_Click">
                        <div class="card-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <h3 class="card-title">Remove Deductions</h3>
                        <p class="card-desc">Manage deductions for resigned employees</p>
                    </asp:LinkButton>

                    <!-- Attendance (Changed to another logo - clock) -->
                    <asp:LinkButton ID="btnUpdateAttendance" runat="server" 
                        CssClass="card" OnClick="btnUpdateAttendance_Click">
                        <div class="card-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="card-title">Update Attendance</h3>
                        <p class="card-desc">Update and modify attendance records</p>
                    </asp:LinkButton>

                    <!-- Holidays -->
                    <asp:LinkButton ID="btnAddHoliday" runat="server" 
                        CssClass="card" OnClick="btnAddHoliday_Click">
                        <div class="card-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <h3 class="card-title">Holidays</h3>
                        <p class="card-desc">Add company holidays</p>
                    </asp:LinkButton>

                    <!-- Initiate Attendance -->
                    <asp:LinkButton ID="btnInitAttendance" runat="server" 
                        CssClass="card" OnClick="btnInitAttendance_Click">
                        <div class="card-icon">
    <i class="fas fa-clock"></i>
</div>
                        <h3 class="card-title">Initiate Attendance</h3>
                        <p class="card-desc">Begin daily attendance tracking by creating new attendance record</p>
                    </asp:LinkButton>

                    <!-- Settings -->
                    <asp:LinkButton ID="btnAttendanceTools" runat="server" 
                        CssClass="card" OnClick="btnAttendanceTools_Click">
                        <div class="card-icon">
                            <i class="fas fa-cog"></i>
                        </div>
                        <h3 class="card-title">More Actions</h3>
                        <p class="card-desc">Redirects to Admin Part 2</p>
                    </asp:LinkButton>
                </div>
            </div>
        </main>

        <!-- Footer removed as per your code -->
    </form>

    <script>
        // Add hover effects
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-5px)';
            });

            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>