<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication1.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University HR Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #5D8AA8; /* Bluish grey background */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background: linear-gradient(135deg, #5D8AA8 0%, #7A9EB1 50%, #98AFC7 100%);
        }

        .container {
            width: 100%;
            max-width: 1200px;
            text-align: center;
        }

        .header {
            margin-bottom: 60px;
            animation: fadeInDown 1s ease;
        }

        .system-name {
            color: white;
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .system-subtitle {
            color: rgba(255,255,255,0.9);
            font-size: 22px;
            font-weight: 300;
            letter-spacing: 1px;
        }

        .login-options {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            animation: fadeInUp 1s ease 0.3s both;
        }

        .login-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            width: 300px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            display: block;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .login-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 40px rgba(0,0,0,0.2);
            background: #f8f9fa;
        }

        .login-card.employee {
            border-top: 5px solid #3498db;
        }

        .login-card.hr {
            border-top: 5px solid #2ecc71;
        }

        .login-card.admin {
            border-top: 5px solid #e74c3c;
        }

        .icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 25px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .employee .icon {
            background: linear-gradient(135deg, #3498db, #2980b9);
        }

        .hr .icon {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
        }

        .admin .icon {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }

        .card-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .card-description {
            color: #5D6D7E;
            font-size: 15px;
            line-height: 1.5;
        }

        .footer {
            margin-top: 60px;
            color: rgba(255,255,255,0.8);
            font-size: 14px;
            animation: fadeIn 1s ease 0.6s both;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive design */
        @media (max-width: 1000px) {
            .login-options {
                gap: 20px;
            }
            
            .login-card {
                width: 280px;
            }
        }

        @media (max-width: 900px) {
            .login-options {
                flex-direction: column;
                align-items: center;
            }
            
            .login-card {
                width: 350px;
            }
            
            .system-name {
                font-size: 36px;
            }
            
            .system-subtitle {
                font-size: 18px;
            }
        }

        @media (max-width: 480px) {
            .login-card {
                width: 100%;
                max-width: 320px;
            }
            
            .system-name {
                font-size: 32px;
            }
            
            body {
                padding: 10px;
            }
        }
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header with System Name -->
            <div class="header">
                <h1 class="system-name">University HR Management System</h1>
            </div>

            <!-- Login Options -->
            <div class="login-options">
                <!-- Employee Login Card -->
                <a href="Login.aspx" class="login-card employee">
                    <div class="icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h3 class="card-title">Academic Employee</h3>
                    <p class="card-description">
                        Access your personal dashboard to view attendance, payroll, performance, and manage leave requests.
                    </p>
                </a>

                <!-- HR Login Card -->
                <a href="HRLogin.aspx" class="login-card hr">
                    <div class="icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="card-title">HR Employee</h3>
                    <p class="card-description">
                        Manage employee records, process applications, handle payroll operations, and generate comprehensive reports.
                    </p>
                </a>

                <!-- Admin Login Card -->
                <a href="AdminLogin.aspx" class="login-card admin">
                    <div class="icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <h3 class="card-title">Admin</h3>
                    <p class="card-description">
                        System configuration, user management, database administration, and overall system maintenance.
                    </p>
                </a>
            </div>

            
        </div>
    </form>
</body>
</html>