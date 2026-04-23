<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Submit_Medical.aspx.cs" Inherits="WebApplication1.Submit_Medical" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Medical Leave</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .main-container {
            width: 95%;
            max-width: 1200px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 40px;
            position: relative;
        }
        
        /* TOP BUTTON - ON THE EDGE OF THE PAGE */
        .top-button {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }
        
        .back-btn {
            background: #5D8AA8;
            color: white;
            border: none;
            border-radius: 12px;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(93, 138, 168, 0.3);
        }
        
        .back-btn:hover {
            background: #7A9EB1;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(93, 138, 168, 0.4);
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
            padding: 0 20px;
            padding-bottom: 25px;
            border-bottom: 2px solid #e5e7eb;
        }
        
        .header h1 {
            color: #1e3a8a;
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
        }
        
        .header h1:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 4px;
            background: linear-gradient(90deg, #1e3a8a 0%, #5D8AA8 100%);
            border-radius: 2px;
        }
        
        .header p {
            color: #6b7280;
            font-size: 18px;
            margin-top: 25px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }
        
        /* FORM CARD STYLES - WIDER */
        .form-card {
            background: white;
            border-radius: 18px;
            padding: 50px;
            border: 2px solid #e5e7eb;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            max-width: 1000px;
            margin: 0 auto;
        }
        
        /* TWO COLUMN LAYOUT FOR WIDER FORM */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 25px;
        }
        
        .form-group-full {
            grid-column: 1 / -1;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e3a8a; /* Changed all labels to #1e3a8a */
            font-size: 16px;
        }
        
        /* Insurance Status label specific styling */
        .insurance-label {
            color: #1e3a8a !important;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            width: 100%;
            padding: 14px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #5D8AA8;
            box-shadow: 0 0 0 3px rgba(93, 138, 168, 0.1);
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
            font-family: Arial, sans-serif;
        }
        
        select.form-control {
            height: 48px;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 8px;
        }
        
        .radio-option {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 20px 16px;
            background: #f8f9fa;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        
        .radio-option:hover {
            background: #e9ecef;
        }
        
        .radio-option input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #1e3a8a;
        }
        
        .radio-option label {
            margin: 0;
            font-weight: normal;
            color: #1e3a8a;
            cursor: pointer;
        }
        
        .note-box {
            background: linear-gradient(135deg, #d1ecf1 0%, #e3f2fd 100%);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 40px;
            border-left: 4px solid #5D8AA8;
            font-size: 16px;
            color: #0c5460;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .note-box strong {
            color: #1e3a8a;
            font-size: 17px;
        }
        
         .submit-btn {
     width: 100%;
     padding: 18px;
     background: linear-gradient(135deg, #5D8AA8 0%, #4a6f8a 100%);
     color: white;
     border: none;
     border-radius: 12px;
     font-size: 18px;
     font-weight: 600;
     cursor: pointer;
     transition: all 0.3s ease;
     margin-top: 20px;
     max-width: 500px;
     display: block;
     margin-left: auto;
     margin-right: auto;
 }
 
 .submit-btn:hover {
     transform: translateY(-3px);
     box-shadow: 0 12px 25px rgba(93, 138, 168, 0.3);
     background: linear-gradient(135deg, #7A9EB1 0%, #5D8AA8 100%);
 }
        
        /* MESSAGE STYLES - FIXED TO STAY UNDER SUBMIT BUTTON */
        .message-container {
            margin-top: 25px;
            min-height: 70px;
            position: relative;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .message-box {
            padding: 18px;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
            font-size: 16px;
            animation: fadeIn 0.5s ease;
            display: block;
            width: 100%;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .success-message {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border: 1px solid #b1dfbb;
        }
        
        .error-message {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border: 1px solid #f1b0b7;
        }
        
        .info-message {
            background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
            color: #0c5460;
            border: 1px solid #abdde5;
        }
        
        /* VALIDATION ERROR STYLES */
        .error-field {
            border-color: #dc3545 !important;
            background-color: #fff8f8;
        }
        
        .error-label {
            color: #dc3545 !important;
        }
        
        .error-hint {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
        
        /* RESPONSIVE */
        @media (max-width: 1024px) {
            .main-container {
                width: 98%;
                padding: 30px;
            }
            
            .form-card {
                padding: 40px;
            }
            
            .form-row {
                gap: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 36px;
            }
            
            .form-card {
                padding: 30px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .top-button {
                position: relative;
                top: 0;
                left: 0;
                margin-bottom: 20px;
            }
            
            .back-btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            .main-container {
                padding: 15px;
            }
            
            .header h1 {
                font-size: 32px;
            }
            
            .form-card {
                padding: 20px;
            }
            
            .note-box {
                padding: 20px;
            }
            
            .submit-btn {
                padding: 16px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <!-- TOP BUTTON - ON THE EDGE OF THE PAGE -->
            <div class="top-button">
                <asp:LinkButton ID="btnBack" runat="server" OnClick="btnBack_Click" 
                    CausesValidation="false" CssClass="back-btn">
                    ← Back to Dashboard
                </asp:LinkButton>
            </div>
            
            <div class="header">
                <br />
                <br />

                <h1>Medical Leave Request</h1>
                <p>Submit your medical leave request with supporting documentation. All fields marked with * are required.</p>
            </div>
            
            <!-- Note box -->
            <div class="note-box">
                <strong>Important Note:</strong> Medical leave requires supporting documentation (medical certificates, doctor's notes) and may require verification by HR. Please ensure all information is accurate and complete before submission.
            </div>
            
            <!-- FORM CARD - WIDER LAYOUT -->
            <div class="form-card">
                <!-- ROW 1: Start Date and End Date -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="<%= txtMedStart.ClientID %>" id="lblMedStart">Start Date *</label>
                        <asp:TextBox ID="txtMedStart" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        <div class="error-hint" id="errorMedStart">Please enter a valid start date</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtMedEnd.ClientID %>" id="lblMedEnd">End Date *</label>
                        <asp:TextBox ID="txtMedEnd" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        <div class="error-hint" id="errorMedEnd">Please enter a valid end date</div>
                    </div>
                </div>
                
                <!-- Medical Type -->
                <div class="form-group">
                    <label for="<%= ddlMedType.ClientID %>" id="lblMedType">Medical Type *</label>
                    <asp:DropDownList ID="ddlMedType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Medical Type --</asp:ListItem>
                        <asp:ListItem Value="sick">Sick Leave</asp:ListItem>
                        <asp:ListItem Value="maternity">Maternity Leave</asp:ListItem>
                    </asp:DropDownList>
                    <div class="error-hint" id="errorMedType">Please select a medical type from the list</div>
                </div>
                 <br />
                 <br />
                
                <!-- Insurance Status -->
                <div class="form-group-full">
                    <label id="lblInsurance" class="insurance-label">Insurance Status *</label>
                    <div class="radio-group">
                        <asp:RadioButtonList ID="rblInsurance" runat="server" 
                            RepeatDirection="Horizontal" CssClass="radio-group">
                            <asp:ListItem Value="1" Text=" Insured"></asp:ListItem>
                          
                            <asp:ListItem Value="0" Text=" Not Insured "></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="error-hint" id="errorInsurance">Please select your insurance status</div>
                </div>
                 <br />
                 <br />
                <br />
                
                <!-- ROW 2: Document Fields -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="<%= txtDocDesc.ClientID %>">Document Description *</label>
                        <asp:TextBox ID="txtDocDesc" runat="server" CssClass="form-control" 
                            placeholder="e.g., Doctor's Certificate, Medical Report, Hospital Discharge Summary"></asp:TextBox>
                        <div class="error-hint" id="errorDocDesc">Please describe your supporting documents</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtFileName.ClientID %>">File Name *</label>
                        <asp:TextBox ID="txtFileName" runat="server" CssClass="form-control" 
                            placeholder="e.g., medical_certificate.pdf, doctor_note.jpg"></asp:TextBox>
                        <div class="error-hint" id="errorFileName">Please enter the document file name</div>
                    </div>
                </div>
                
                <!-- Disability Details -->
                <div class="form-group">
                    <label for="<%= txtDisability.ClientID %>">Disability Details (optional)</label>
                    <asp:TextBox ID="txtDisability" runat="server" TextMode="MultiLine" 
                        Rows="5" CssClass="form-control" 
                        placeholder="Enter any additional information about your medical condition, treatment plan, or special accommodations needed..."></asp:TextBox>
                </div>
                
                <!-- Submit Button - Centered but wide -->
                <asp:Button ID="btnMedSubmit" runat="server" CssClass="submit-btn" 
                    Text="Submit Medical Leave Request" OnClick="btnMedSubmit_Click" 
                    OnClientClick="return validateForm();" />
                
                <!-- Message display - Fixed container with reserved space -->
                <div class="message-container">
                    <asp:Label ID="lblMedMsg" runat="server" CssClass="message-box"></asp:Label>
                </div>
            </div>
        </div>
        
        <!-- JavaScript to handle validation and message styling -->
        <script>
            // Prevent form from scrolling to top on submit
            document.addEventListener('DOMContentLoaded', function () {
                // Store current scroll position
                var scrollPosition = window.pageYOffset || document.documentElement.scrollTop;

                // Function to restore scroll position
                function restoreScroll() {
                    window.scrollTo(0, scrollPosition);
                }

                // Apply to all form submissions
                document.getElementById('<%= form1.ClientID %>').addEventListener('submit', function () {
                    // Store position before submission
                    scrollPosition = window.pageYOffset || document.documentElement.scrollTop;

                    // Restore scroll after a short delay
                    setTimeout(restoreScroll, 100);
                });

                // Style existing messages
                styleMessages();

                // Add hover effects to form controls
                var formControls = document.querySelectorAll('.form-control');
                formControls.forEach(function (control) {
                    control.addEventListener('focus', function () {
                        this.style.transform = 'translateY(-2px)';
                        this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.1)';
                        // Remove error styling on focus
                        this.classList.remove('error-field');
                        var label = document.querySelector('label[for="' + this.id + '"]');
                        if (label) label.classList.remove('error-label');
                        hideError(this.id + '_error');
                    });

                    control.addEventListener('blur', function () {
                        this.style.transform = 'translateY(0)';
                        this.style.boxShadow = 'none';
                    });
                });

                // Add change listeners to clear errors
                document.getElementById('<%= txtMedStart.ClientID %>').addEventListener('change', function () {
                    clearError('errorMedStart');
                });
                document.getElementById('<%= txtMedEnd.ClientID %>').addEventListener('change', function () {
                    clearError('errorMedEnd');
                });
                document.getElementById('<%= ddlMedType.ClientID %>').addEventListener('change', function () {
                    clearError('errorMedType');
                });
                document.getElementById('<%= txtDocDesc.ClientID %>').addEventListener('input', function() {
                    clearError('errorDocDesc');
                });
                document.getElementById('<%= txtFileName.ClientID %>').addEventListener('input', function() {
                    clearError('errorFileName');
                });
                document.querySelectorAll('input[name="<%= rblInsurance.ClientID %>"]').forEach(function(radio) {
                    radio.addEventListener('change', function() {
                        clearError('errorInsurance');
                    });
                });
                
                // Set default dates
                setDefaultDates();
            });
            
            function setDefaultDates() {
                var startDate = document.getElementById('<%= txtMedStart.ClientID %>');
                var endDate = document.getElementById('<%= txtMedEnd.ClientID %>');
                
                if (startDate && !startDate.value) {
                    var today = new Date().toISOString().split('T')[0];
                    startDate.value = today;
                }
                
                if (endDate && !endDate.value) {
                    var tomorrow = new Date();
                    tomorrow.setDate(tomorrow.getDate() + 1);
                    endDate.value = tomorrow.toISOString().split('T')[0];
                }
            }
            
            function styleMessages() {
                var messageLabel = document.getElementById('<%= lblMedMsg.ClientID %>');
                
                if (messageLabel) {
                    var messageText = messageLabel.textContent || messageLabel.innerText;
                    
                    if (messageText.trim() !== '') {
                        if (messageText.includes('✅') || messageText.includes('successfully') || 
                            messageText.includes('Success') || messageText.includes('Submitted')) {
                            messageLabel.className = 'message-box success-message';
                        } else if (messageText.includes('❌') || messageText.includes('Error') || 
                                   messageText.includes('Please') || messageText.includes('Required')) {
                            messageLabel.className = 'message-box error-message';
                        } else {
                            messageLabel.className = 'message-box info-message';
                        }
                        
                        // Scroll to message container smoothly
                        var messageContainer = messageLabel.closest('.message-container');
                        if (messageContainer) {
                            setTimeout(function() {
                                messageContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }, 100);
                        }
                    }
                }
            }
            
            function validateForm() {
                var isValid = true;
                
                // Clear all previous errors
                clearAllErrors();
                
                // Validate Start Date
                var startDate = document.getElementById('<%= txtMedStart.ClientID %>').value;
                if (!startDate) {
                    showError('txtMedStart', 'errorMedStart', 'Please enter a start date');
                    isValid = false;
                }
                
                // Validate End Date
                var endDate = document.getElementById('<%= txtMedEnd.ClientID %>').value;
                if (!endDate) {
                    showError('txtMedEnd', 'errorMedEnd', 'Please enter an end date');
                    isValid = false;
                }
                
                // Validate Medical Type
                var medType = document.getElementById('<%= ddlMedType.ClientID %>').value;
                if (!medType) {
                    showError('ddlMedType', 'errorMedType', 'Please select a medical type');
                    isValid = false;
                }
                
                // Validate Insurance Status
                var insuranceSelected = document.querySelector('input[name="<%= rblInsurance.ClientID %>"]:checked');
                if (!insuranceSelected) {
                    showError('rblInsurance', 'errorInsurance', 'Please select insurance status');
                    isValid = false;
                }
                
                // Validate Document Description
                var docDesc = document.getElementById('<%= txtDocDesc.ClientID %>').value;
                if (!docDesc.trim()) {
                    showError('txtDocDesc', 'errorDocDesc', 'Please describe your supporting documents');
                    isValid = false;
                }
                
                // Validate File Name
                var fileName = document.getElementById('<%= txtFileName.ClientID %>').value;
                if (!fileName.trim()) {
                    showError('txtFileName', 'errorFileName', 'Please enter the document file name');
                    isValid = false;
                }

                // If invalid, scroll to first error
                if (!isValid) {
                    var firstError = document.querySelector('.error-field');
                    if (firstError) {
                        setTimeout(function () {
                            firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }, 100);
                    }
                    return false; // Prevent form submission
                }

                return true; // Allow form submission
            }

            function showError(fieldId, errorId, message) {
                var field = document.getElementById(fieldId);
                var error = document.getElementById(errorId);
                var label = document.querySelector('label[for="' + fieldId + '"]');

                if (field) {
                    field.classList.add('error-field');
                    field.focus();
                }
                if (label) {
                    label.classList.add('error-label');
                }
                if (error) {
                    error.textContent = message;
                    error.style.display = 'block';
                }
            }

            function clearError(errorId) {
                var error = document.getElementById(errorId);
                if (error) {
                    error.style.display = 'none';
                }
            }

            function clearAllErrors() {
                // Clear field errors
                var errorFields = document.querySelectorAll('.error-field');
                errorFields.forEach(function (field) {
                    field.classList.remove('error-field');
                });

                // Clear label errors
                var errorLabels = document.querySelectorAll('.error-label');
                errorLabels.forEach(function (label) {
                    label.classList.remove('error-label');
                });

                // Clear error hints
                var errorHints = document.querySelectorAll('.error-hint');
                errorHints.forEach(function (hint) {
                    hint.style.display = 'none';
                });
            }

            // Prevent scrolling to top on postback
            window.onload = function () {
                if (typeof (Sys) !== 'undefined') {
                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    prm.add_endRequest(function () {
                        // Restore scroll position after AJAX postback
                        var scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
                        window.scrollTo(0, scrollPosition);
                        styleMessages();
                    });
                }
            };
        </script>
    </form>
</body>
</html>