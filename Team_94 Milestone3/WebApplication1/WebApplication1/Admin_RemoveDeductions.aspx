<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_RemoveDeductions.aspx.cs" Inherits="WebApplication1.Admin_RemoveDeductions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Remove Deductions</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --border: #e9ecef;
            --success-color: #27ae60;
            --warning-color: #f39c12;
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
            max-width: 1000px;
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
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.25);
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
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.25);
        }

        .content {
            padding: 3rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        /* Simple Button */
        .action-btn {
            background: var(--admin-color);
            color: white;
            border: none;
            padding: 1.25rem;
            border-radius: 10px;
            font-size: 1.125rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin: 2rem 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .action-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.3);
        }

        .action-btn:active {
            transform: translateY(0);
        }

        /* Result Message */
        .result-message {
            margin-top: 1.5rem;
            padding: 1.25rem;
            border-radius: 10px;
            font-weight: 500;
            text-align: center;
            display: none;
            font-size: 1rem;
        }

        .result-message.success {
            background: rgba(39, 174, 96, 0.1);
            border: 1px solid rgba(39, 174, 96, 0.2);
            color: var(--success-color);
            display: block;
        }

        .result-message.error {
            background: rgba(231, 76, 60, 0.1);
            border: 1px solid rgba(231, 76, 60, 0.2);
            color: var(--admin-color);
            display: block;
        }

        /* Description */
        .description {
            color: var(--text-light);
            font-size: 1rem;
            line-height: 1.7;
            text-align: center;
            margin-bottom: 1.5rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Warning Box - Initially visible, hidden after execution */
        .warning-box {
            background: rgba(243, 156, 18, 0.1);
            border: 1px solid rgba(243, 156, 18, 0.2);
            border-left: 4px solid var(--warning-color);
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 1.5rem;
            display: block;
        }

        .warning-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--warning-color);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 1rem;
        }

        .warning-text {
            color: var(--text-dark);
            font-size: 0.95rem;
            line-height: 1.6;
        }

        /* Info Section */
        .info-section {
            background: rgba(52, 152, 219, 0.05);
            border: 1px solid rgba(52, 152, 219, 0.1);
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 2rem;
        }

        .info-title {
            color: #3498db;
            font-weight: 600;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-list {
            list-style: none;
            padding-left: 0;
        }

        .info-list li {
            padding: 0.5rem 0;
            color: var(--text-light);
            font-size: 0.95rem;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }

        .info-list li:before {
            content: "•";
            color: #3498db;
            font-weight: bold;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                max-width: 95%;
            }
            
            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .content {
                padding: 2rem;
            }
            
            .header {
                padding: 1.5rem 2rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 15px;
            }
            
            .container {
                max-width: 100%;
            }
            
            .header {
                padding: 1.25rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .page-title i {
                width: 40px;
                height: 40px;
                font-size: 1.25rem;
            }
            
            .content {
                padding: 1.75rem;
            }
            
            .header-actions {
                flex-direction: column;
                width: 100%;
            }
            
            .back-btn, .logout-btn {
                width: 100%;
                justify-content: center;
                margin-bottom: 5px;
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
                        <i class="fas fa-dollar-sign"></i>
                        Remove Deductions
                    </h1>
                    <div class="header-actions">
                        <a href="AdminDashboard.aspx" class="back-btn">
                            <i class="fas fa-arrow-left"></i>
                            Back to Dashboard
                        </a>
                        <a href="Home.aspx?logout=true" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="content">
                <h2 class="section-title">Remove Deductions for Resigned Employees</h2>
                
                <p class="description">
                    This procedure will remove all payroll deductions for employees who have resigned from the company. 
                    It should be executed at the end of each payroll cycle to ensure accurate financial records.
                </p>

                <!-- Action Button -->
                <asp:Button ID="btnRemove" runat="server" Text="Run Deduction Removal Procedure"
                    OnClick="btnRemove_Click" CssClass="action-btn" 
                    OnClientClick="hideWarning();" />

                <!-- Warning Box - Will be hidden after execution -->
                <div class="warning-box" id="warningBox">
                    <div class="warning-title">
                        <i class="fas fa-exclamation-triangle"></i>
                        Important Warning
                    </div>
                    <p class="warning-text">
                        This action cannot be undone. It will permanently remove deduction records 
                        for all resigned employees. Please verify the current employee status 
                        and backup your data before proceeding.
                    </p>
                </div>

                <!-- Result Message -->
                <asp:Label ID="lblResult" runat="server" CssClass="result-message"></asp:Label>

            </div>
        </div>
    </form>

    <script>
        // Function to hide warning when button is clicked
        function hideWarning() {
            document.getElementById('warningBox').style.display = 'none';
        }

        // Update result display and manage warning visibility
        document.addEventListener('DOMContentLoaded', function () {
            const resultLabel = document.getElementById('<%= lblResult.ClientID %>');
            const resultText = resultLabel.textContent.trim();
            const warningBox = document.getElementById('warningBox');
            
            // Check if form was submitted (postback)
            const isPostBack = <%= Page.IsPostBack.ToString().ToLower() %>;

            if (isPostBack && resultText) {
                // Hide warning if this is a postback (form was submitted)
                warningBox.style.display = 'none';

                // Determine success or error based on text
                if (resultText.toLowerCase().includes('success') ||
                    resultText.toLowerCase().includes('removed') ||
                    resultText.toLowerCase().includes('completed')) {
                    resultLabel.className = 'result-message success';
                } else if (resultText.toLowerCase().includes('error') ||
                    resultText.toLowerCase().includes('failed') ||
                    resultText.toLowerCase().includes('problem')) {
                    resultLabel.className = 'result-message error';
                }

                resultLabel.style.display = 'block';
            }

            // If there's no result text and it's not a postback, show warning
            if (!isPostBack && !resultText) {
                warningBox.style.display = 'block';
            }
        });
    </script>
</body>
</html>