<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_AddHoliday.aspx.cs"
    Inherits="WebApplication1.Admin_AddHoliday"
    UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Holiday</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --border: #e9ecef;
            --success-color: #27ae60;
            --input-bg: #f8f9fa;
            --error-color: #e74c3c;
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
            padding: 20px;
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
            margin-bottom: 2rem;
            text-align: center;
        }

        /* Form Styling */
        .form-container {
            max-width: 500px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 0.95rem;
        }

        .form-input {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 1rem;
            color: var(--text-dark);
            background: var(--input-bg);
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--admin-color);
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
            background: white;
        }

        .form-input::placeholder {
            color: #adb5bd;
        }

        /* Date format hint */
        .date-hint {
            font-size: 0.875rem;
            color: var(--text-light);
            margin-top: 0.25rem;
            font-style: italic;
        }

        /* Button Styling */
        .action-btn {
            background: var(--admin-color);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 8px;
            font-size: 1.125rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
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

        /* Validation Error Styling */
        .validation-error {
            color: var(--error-color);
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: block;
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

    <script type="text/javascript">
        // Strict client-side ISO date validator (YYYY-MM-DD)
        function clientValidateIsoDate(source, args) {
            var v = args.Value ? args.Value.trim() : '';
            if (!v) { args.IsValid = false; return; } // required
            var isoStrict = /^(\d{4})-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/;
            var m = isoStrict.exec(v);
            if (!m) { args.IsValid = false; return; }
            var year = parseInt(m[1], 10), month = parseInt(m[2], 10), day = parseInt(m[3], 10);
            var dt = new Date(year, month - 1, day);
            args.IsValid = (dt.getFullYear() === year && dt.getMonth() + 1 === month && dt.getDate() === day);
        }

        // Client-side name validator: required, letters + spaces only, max 50
        function clientValidateName(source, args) {
            var v = args.Value ? args.Value.trim() : '';
            if (!v) { args.IsValid = false; return; }
            if (v.length > 50) { args.IsValid = false; return; }
            var re = /^[A-Za-z\s]+$/;
            args.IsValid = re.test(v);
        }

        // Clear the server message label when user edits any input
        function clearServerMessage() {
            try {
                var lbl = document.getElementById('<%= lblRes.ClientID %>');
                if (lbl) {
                    lbl.innerText = '';
                    lbl.className = 'result-message';
                }
            } catch (e) { /* ignore */ }
        }

        // Attach clearServerMessage to inputs on page load (for non-ASP.NET browsers)
        function attachClearHandlers() {
            var ids = ['<%= txtHolidayName.ClientID %>', '<%= txtFromDate.ClientID %>', '<%= txtToDate.ClientID %>'];
            for (var i = 0; i < ids.length; i++) {
                var el = document.getElementById(ids[i]);
                if (el) {
                    el.addEventListener('input', clearServerMessage);
                    el.addEventListener('change', clearServerMessage);
                    el.addEventListener('focus', clearServerMessage);
                }
            }
        }

        if (window.addEventListener) {
            window.addEventListener('load', attachClearHandlers, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', attachClearHandlers);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <div class="header-content">
                    <h1 class="page-title">
                        <i class="fas fa-calendar-plus"></i>
                        Add Holiday
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
                <h2 class="section-title">Add New Official Holiday</h2>

                <div class="form-container">
                    <!-- Holiday Name -->
                    <div class="form-group">
                        <label class="form-label" for="<%= txtHolidayName.ClientID %>">
                            <i class="fas fa-tag"></i> Holiday Name
                        </label>
                        <asp:TextBox ID="txtHolidayName" runat="server" 
                            CssClass="form-input" 
                            placeholder="Enter holiday name"
                            MaxLength="50"
                            oninput="clearServerMessage()" onchange="clearServerMessage()" />
                        <asp:RequiredFieldValidator ID="valNameReq" runat="server"
                            ControlToValidate="txtHolidayName"
                            ErrorMessage="Holiday name is required."
                            Display="Dynamic" CssClass="validation-error" />
                        <asp:CustomValidator ID="valNameFormat" runat="server"
                            ControlToValidate="txtHolidayName"
                            ErrorMessage="Name must be letters and spaces only (max 50)."
                            ClientValidationFunction="clientValidateName"
                            OnServerValidate="valNameFormat_ServerValidate"
                            Display="Dynamic" CssClass="validation-error" />
                    </div>

                    <!-- From Date -->
                    <div class="form-group">
                        <label class="form-label" for="<%= txtFromDate.ClientID %>">
                            <i class="fas fa-calendar-day"></i> From Date
                        </label>
                        <asp:TextBox ID="txtFromDate" runat="server" 
                            CssClass="form-input" 
                            placeholder="YYYY-MM-DD"
                            oninput="clearServerMessage()" onchange="clearServerMessage()" />
                        <div class="date-hint">Format: YYYY-MM-DD (e.g., 2024-12-25)</div>
                        <asp:RequiredFieldValidator ID="valFromReq" runat="server"
                            ControlToValidate="txtFromDate"
                            ErrorMessage="From date is required."
                            Display="Dynamic" CssClass="validation-error" />
                        <asp:CustomValidator ID="valFromDate" runat="server"
                            ControlToValidate="txtFromDate"
                            ErrorMessage="From date must be a valid date in YYYY-MM-DD."
                            ClientValidationFunction="clientValidateIsoDate"
                            OnServerValidate="valFromDate_ServerValidate"
                            Display="Dynamic" CssClass="validation-error" />
                    </div>

                    <!-- To Date -->
                    <div class="form-group">
                        <label class="form-label" for="<%= txtToDate.ClientID %>">
                            <i class="fas fa-calendar-check"></i> To Date
                        </label>
                        <asp:TextBox ID="txtToDate" runat="server" 
                            CssClass="form-input" 
                            placeholder="YYYY-MM-DD"
                            oninput="clearServerMessage()" onchange="clearServerMessage()" />
                        <div class="date-hint">Format: YYYY-MM-DD (e.g., 2024-12-31)</div>
                        <asp:RequiredFieldValidator ID="valToReq" runat="server"
                            ControlToValidate="txtToDate"
                            ErrorMessage="To date is required."
                            Display="Dynamic" CssClass="validation-error" />
                        <asp:CustomValidator ID="valToDate" runat="server"
                            ControlToValidate="txtToDate"
                            ErrorMessage="To date must be a valid date in YYYY-MM-DD."
                            ClientValidationFunction="clientValidateIsoDate"
                            OnServerValidate="valToDate_ServerValidate"
                            Display="Dynamic" CssClass="validation-error" />
                    </div>

                    <!-- Add Button -->
                    <asp:Button ID="btnAdd" runat="server" Text="Add Holiday" 
                        OnClick="btnAdd_Click" CssClass="action-btn" />

                    <!-- Result Message -->
                    <asp:Label ID="lblRes" runat="server" CssClass="result-message"></asp:Label>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Update result display
        document.addEventListener('DOMContentLoaded', function() {
            const resultLabel = document.getElementById('<%= lblRes.ClientID %>');
            const resultText = resultLabel.textContent.trim();
            
            if (resultText) {
                // Determine success or error based on text
                if (resultText.toLowerCase().includes('success') || 
                    resultText.toLowerCase().includes('added') ||
                    resultText.toLowerCase().includes('saved')) {
                    resultLabel.className = 'result-message success';
                    
                    // Clear form fields on success after 1 second
                    setTimeout(function() {
                        document.getElementById('<%= txtHolidayName.ClientID %>').value = '';
                        document.getElementById('<%= txtFromDate.ClientID %>').value = '';
                        document.getElementById('<%= txtToDate.ClientID %>').value = '';
                    }, 1000);
                } else if (resultText.toLowerCase().includes('error') || 
                          resultText.toLowerCase().includes('failed') ||
                          resultText.toLowerCase().includes('invalid')) {
                    resultLabel.className = 'result-message error';
                }
                
                resultLabel.style.display = 'block';
            }
            
            // Add date format validation
            const dateInputs = document.querySelectorAll('input[placeholder*="YYYY-MM-DD"]');
            dateInputs.forEach(input => {
                input.addEventListener('blur', function() {
                    const value = this.value.trim();
                    if (value && !/^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/.test(value)) {
                        this.style.borderColor = '#e74c3c';
                        this.style.boxShadow = '0 0 0 3px rgba(231, 76, 60, 0.1)';
                    } else {
                        this.style.borderColor = '';
                        this.style.boxShadow = '';
                    }
                });
            });
            
            // Focus on first input
            document.getElementById('<%= txtHolidayName.ClientID %>').focus();
        });
    </script>
</body>
</html>