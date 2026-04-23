<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_InitiateAttendance.aspx.cs" Inherits="WebApplication1.Admin_InitiateAttendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Initiate Attendance</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --border: #e9ecef;
            --success-color: #27ae60;
            --info-color: #3498db;
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

        .result-message {
            margin-top: 1.5rem;
            padding: 1.25rem;
            border-radius: 10px;
            font-weight: 500;
            text-align: center;
            font-size: 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .result-message.success {
            background: rgba(39, 174, 96, 0.1);
            border: 1px solid rgba(39, 174, 96, 0.2);
            color: var(--success-color);
        }

        .result-message.info {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.2);
            color: var(--info-color);
        }

        .result-message.warning {
            background: rgba(243, 156, 18, 0.1);
            border: 1px solid rgba(243, 156, 18, 0.2);
            color: var(--warning-color);
        }

        .result-message.error {
            background: rgba(231, 76, 60, 0.1);
            border: 1px solid rgba(231, 76, 60, 0.2);
            color: var(--admin-color);
        }

        .message-content {
            text-align: center;
            width: 100%;
        }

        .message-title {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }

        .message-details {
            font-size: 0.95rem;
            color: inherit;
            opacity: 0.9;
        }

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
            
            .message-title {
                font-size: 1rem;
            }
            
            .message-details {
                font-size: 0.9rem;
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
                        <i class="fas fa-calendar-check"></i>
                        Initiate Attendance
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
                <h2 class="section-title">Initialize Attendance System for Today</h2>
                
                <p class="description">
                    This procedure will initialize the attendance tracking system for today's date. 
                    It prepares the system for employee check-ins and ensures proper attendance recording.
                </p>

                <!-- Action Button -->
                <asp:Button ID="btnInit" runat="server" Text="Initiate Attendance for Today"
                    OnClick="btnInit_Click" CssClass="action-btn" />

                <!-- Result Message -->
                <asp:Label ID="lblRes" runat="server" CssClass="result-message"></asp:Label>
            </div>
        </div>
    </form>

    <script>
        // Update result display based on message content
        document.addEventListener('DOMContentLoaded', function () {
            const resultLabel = document.getElementById('<%= lblRes.ClientID %>');
            const resultText = resultLabel.textContent.trim();

            if (resultText) {
                // Add structure to the message
                const fullText = resultLabel.innerHTML;

                // Check if the message contains the attendance initialization text
                if (resultText.toLowerCase().includes('attendance initialized') ||
                    resultText.toLowerCase().includes('rows affected')) {

                    // Format the message with title and details
                    let messageHTML = '';

                    if (resultText.includes('Attendance initialized')) {
                        const parts = resultText.split('. ');
                        if (parts.length >= 2) {
                            messageHTML = `
                                <div class="message-content">
                                    <div class="message-title">${parts[0]}.</div>
                                    <div class="message-details">${parts.slice(1).join('. ')}</div>
                                </div>
                            `;
                        } else {
                            messageHTML = `
                                <div class="message-content">
                                    <div class="message-title">${resultText}</div>
                                </div>
                            `;
                        }

                        // Use SUCCESS color (green) for attendance initialization messages
                        resultLabel.className = 'result-message success';
                    } else {
                        messageHTML = `
                            <div class="message-content">
                                <div class="message-title">${resultText}</div>
                            </div>
                        `;
                    }

                    resultLabel.innerHTML = messageHTML;
                }

                // Determine message type based on text
                if (resultText.toLowerCase().includes('success') ||
                    resultText.toLowerCase().includes('completed successfully') ||
                    resultText.toLowerCase().includes('attendance initialized')) {
                    resultLabel.className = 'result-message success';
                } else if (resultText.toLowerCase().includes('error') ||
                    resultText.toLowerCase().includes('failed')) {
                    resultLabel.className = 'result-message error';
                } else if (resultText.toLowerCase().includes('info') ||
                    resultText.toLowerCase().includes('note')) {
                    resultLabel.className = 'result-message info';
                } else if (resultText.toLowerCase().includes('warning') ||
                    resultText.toLowerCase().includes('caution')) {
                    resultLabel.className = 'result-message warning';
                }
            }
        });
    </script>
</body>
</html>