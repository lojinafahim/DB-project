<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #5D8AA8; /* Bluish grey to match homepage */
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
            width: 380px; /* Increased width */
            border-radius: 15px; /* More rounded corners */
            box-shadow: 0 15px 30px rgba(0,0,0,0.15); /* Softer shadow */
            text-align: center;
            position: relative;
            border: 1px solid rgba(255,255,255,0.2);
        }

        /* Logo placeholder - updated to match homepage */
        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #3498db, #2980b9); /* Blue gradient like homepage */
            border-radius: 50%;
            margin: 0 auto 20px auto;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 36px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 25px;
            color: #2c3e50; /* Darker color for better contrast */
            font-size: 24px;
        }

        .input-box {
            width: 100%;
            padding: 12px; /* Slightly more padding */
            margin: 12px 0; /* More spacing */
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-box:focus {
            border-color: #3498db; /* Blue focus border */
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .btn-login {
            width: 160px; /* Slightly wider */
            background: linear-gradient(135deg, #3498db, #2980b9); /* Gradient like homepage */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px; /* More spacing */
            display: block;
            margin-left: auto;
            margin-right: auto;
            transition: all 0.3s;
            font-weight: bold;
            font-size: 15px;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.2);
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #2980b9, #1f6399);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(52, 152, 219, 0.3);
        }

        /* Error label - always takes space, white by default */
        .error-label {
            color: #e74c3c; /* Red color for errors */
            margin-top: 15px;
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

        /* Back to Home link */
        .back-home {
            position: absolute;
            top: 15px;
            left: 15px;
            color: #3498db;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.3s;
        }

        .back-home:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        /* Placeholder styling */
        .input-box::placeholder {
            color: #95a5a6;
            font-size: 13px;
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

            <!-- Logo placeholder -->
            <div class="logo">E</div>
            
            <h2>Employee Login</h2>

            <asp:TextBox ID="txtEmpID" runat="server" CssClass="input-box"
                Placeholder="Employee ID" autocomplete="off"></asp:TextBox>

            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box"
                TextMode="Password" Placeholder="Password" autocomplete="off"></asp:TextBox>

            <asp:Button ID="btnLogin" runat="server" Text="Login"
                CssClass="btn-login" OnClick="signin_Click" />

            <asp:Label ID="lblError" runat="server" CssClass="error-label"></asp:Label>
        </div>
    </form>
</body>
</html>