<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="WebApplication1.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #5D8AA8;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #5D8AA8 0%, #7A9EB1 50%, #98AFC7 100%);
        }

        .login-container {
            background: white;
            padding: 40px 30px;
            width: 380px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            text-align: center;
            position: relative;
            border: 1px solid rgba(255,255,255,0.2);
            border-top: 5px solid #e74c3c; /* Admin red from Home page */
        }

        /* Logo placeholder - using Admin's red gradient from Home page */
        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #e74c3c, #c0392b); /* Red gradient for Admin from Home page */
            border-radius: 50%;
            margin: 0 auto 20px auto;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 36px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.2);
        }

        h2 {
            margin-bottom: 25px;
            color: #2c3e50;
            font-size: 24px;
            font-weight: 600;
        }

        .input-box {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-box:focus {
            border-color: #e74c3c; /* Red focus for Admin from Home page */
            outline: none;
            box-shadow: 0 0 5px rgba(231, 76, 60, 0.3);
        }

        .btn-login {
            width: 160px;
            background: linear-gradient(135deg, #e74c3c, #c0392b); /* Red gradient for Admin from Home page */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
            transition: all 0.3s;
            font-weight: bold;
            font-size: 15px;
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.2);
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.3);
        }

        /* Error label - identical to HR login */
        .error-label {
            color: #e74c3c;
            margin-top: 15px;
            display: block;
            min-height: 20px;
            font-size: 14px;
            font-weight: bold;
            padding: 10px;
            border-radius: 5px;
            background-color: white;
            border: 1px solid transparent;
            visibility: visible;
            opacity: 1;
        }

        .error-label:empty {
            color: transparent;
            background-color: white;
            border-color: transparent;
        }

        .error-label:not(:empty) {
            background-color: rgba(231, 76, 60, 0.1);
            border: 1px solid rgba(231, 76, 60, 0.2);
        }

        /* Back to Home link - with Admin red color from Home page */
        .back-home {
            position: absolute;
            top: 15px;
            left: 15px;
            color: #e74c3c; /* Admin red from Home page */
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.3s;
        }

        .back-home:hover {
            color: #c0392b;
            text-decoration: underline;
        }

        .input-box::placeholder {
            color: #95a5a6;
            font-size: 13px;
        }

        /* Additional styling to match Home page admin card */
        .login-container {
            animation: fadeInUp 0.5s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <!-- Back to Home link -->
            <a href="Home.aspx" class="back-home">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>

            <!-- Logo placeholder - Using cog icon from Home page admin card -->
            <div class="logo">
                <i class="fas fa-cogs"></i>
            </div>
            
            <h2>Admin Login</h2>

            <!-- Admin ID field -->
            <asp:TextBox ID="txtAdminId" runat="server" CssClass="input-box"
                Placeholder="Admin ID" autocomplete="off"></asp:TextBox>

            <!-- Password field -->
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box"
                TextMode="Password" Placeholder="Password" autocomplete="off"></asp:TextBox>

            <!-- Login button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login"
                CssClass="btn-login" OnClick="btnLogin_Click" />

            <!-- Error message label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="error-label"></asp:Label>
        </div>
    </form>
</body>
</html>