<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpDashboard.aspx.cs" Inherits="WebApplication1.EmpDashboard" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Employee Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8fafc;
        }
        .sidebar {
            width: 280px;
            height: 100vh;
            background: linear-gradient(180deg, #5D8AA8 0%, #7A9EB1 100%);
            padding: 30px 20px;
            color: white;
            position: fixed;
            box-shadow: 2px 0 15px rgba(0,0,0,0.1);
            border-right: 1px solid rgba(255,255,255,0.15);
            overflow-y: auto;
        }
        .sidebar h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 40px;
            text-align: center;
            letter-spacing: 0.5px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .menu-btn {
            width: 100%;
            padding: 14px 22px;
            margin-bottom: 8px;
            background: rgba(255,255,255,0.1);
            color: white;
            border: none;
            border-left: 3px solid transparent;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: left;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .menu-btn:hover {
            background: rgba(255,255,255,0.2);
            border-left: 3px solid #3498db;
            transform: translateX(5px);
        }
        .logout-btn {
            width: 100%;
            background: rgba(255,255,255,0.1);
            color: white;
            margin-top: 40px;
            font-weight: 500;
        }
        .logout-btn:hover {
            background: rgba(255,255,255,0.2);
            border-left: 3px solid #e74c3c;
            transform: translateX(5px);
        }
        .content {
            margin-left: 280px;
            padding: 40px;
            min-height: 100vh;
            background-color: #f8fafc;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e2e8f0;
        }
        .header h1 {
            font-size: 36px;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
        }
        .dashboard-corner-btn {
            padding: 12px 24px;
            background: #5D8AA8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .dashboard-corner-btn:hover {
            background: #4a7694;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(93, 138, 168, 0.3);
        }
        .welcome-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .welcome-card h2 {
            font-size: 28px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }
        .welcome-card p {
            color: #4a5568;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 0;
        }
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
            text-align: center;
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #5D8AA8;
            margin-bottom: 10px;
        }
        .stat-label {
            color: #718096;
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        /* Message Styling */
        #lblMessage {
            display: block;
            padding: 15px 20px;
            background: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
            border-radius: 8px;
            margin-bottom: 30px;
            font-weight: 500;
        }
        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 20px;
            }
            .content {
                margin-left: 0;
                padding: 30px 20px;
            }
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            .header h1 {
                font-size: 28px;
            }
            .quick-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <h1>Employee Actions</h1>
            <button runat="server" onserverclick="btnAccidental_Click" class="menu-btn">
                <span>📋</span>
                <span>Accidental Leave</span>
            </button>
            <button runat="server" onserverclick="btnMedical_Click" class="menu-btn">
                <span>🏥</span>
                <span>Medical Leave</span>
            </button>
            <button runat="server" onserverclick="btnUnpaid_Click" class="menu-btn">
                <span>💼</span>
                <span>Unpaid Leave</span>
            </button>
            <button runat="server" onserverclick="btnCompensation_Click" class="menu-btn">
                <span>💰</span>
                <span>Compensation Leave</span>
            </button>
            <button runat="server" onserverclick="btnApproveUnpaid_Click" class="menu-btn">
                <span>✅</span>
                <span>Approve Unpaid Leaves</span>
            </button>
            <button runat="server" onserverclick="btnApproveAnnual_Click" class="menu-btn">
                <span>✅</span>
                <span>Approve Annual Leaves</span>
            </button>
            <button runat="server" onserverclick="btnEvaluation_Click" class="menu-btn">
                <span>📊</span>
                <span>Evaluate Employee</span>
            </button>
            
            <asp:Button ID="btnLogout" 
                        runat="server"
                        Text="🚪 Logout" 
                        CssClass="menu-btn logout-btn"
                        OnClick="btnLogout_Click" />
        </div>
        
        <!-- Main Content -->
        <div class="content">
            <div class="header">
                <h1>Employee Dashboard</h1>
                <asp:Button ID="btnDashboard" 
                            runat="server"
                            Text="🏠 Main Dashboard" 
                            CssClass="dashboard-corner-btn"
                            OnClick="btnDashboard_Click" />
            </div>
            
            <!-- Message Display -->
            <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
            
            <!-- Welcome Card -->
            <div class="welcome-card">
                <h2>Welcome to Employee Actions</h2>
                <p>Manage your leave requests, approvals, and employee evaluations from this centralized dashboard. Select an action from the sidebar to get started.</p>
            </div>
            
            <!-- Quick Stats (Optional - can be removed if not needed) -->
            <div class="quick-stats">
                <div class="stat-card">
                    <div class="stat-number">4</div>
                    <div class="stat-label">Leave Types</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">2</div>
                    <div class="stat-label">Approval Types</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">1</div>
                    <div class="stat-label">Evaluation Tool</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">7</div>
                    <div class="stat-label">Total Actions</div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>