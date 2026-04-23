<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Submit_unpaid.aspx.cs" Inherits="WebApplication1.Submit_unpaid" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Unpaid Leave</title>
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
        
        /* FORM CARD STYLES */
        .form-card {
            background: white;
            border-radius: 18px;
            padding: 50px;
            border: 2px solid #e5e7eb;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            max-width: 900px;
            margin: 0 auto;
        }
        
        /* TWO COLUMN LAYOUT FOR DATES */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 25px;
        }
        
        .form-group {
            margin-bottom: 30px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e3a8a;
            font-size: 16px;
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
        
        /* MESSAGE STYLES */
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
                <h1>Unpaid Leave Request</h1>
                <p>Submit your unpaid leave request. All fields marked with * are required. Unpaid leave is limited to a maximum of 30 days per year.</p>
            </div>
            
            <!-- Note box -->
            <div class="note-box">
                <strong>Important Note:</strong> Unpaid leave is limited to a maximum of 30 days per year and requires supporting documentation. Please ensure you provide accurate information and proper documentation.
            </div>
            
            <!-- FORM CARD -->
            <div class="form-card">
                <!-- ROW 1: Start Date and End Date -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="<%= txtStartDate.ClientID %>" id="lblStartDate">Start Date *</label>
                        <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        <div class="error-hint" id="errorStartDate">Please enter a valid start date</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtEndDate.ClientID %>" id="lblEndDate">End Date *</label>
                        <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        <div class="error-hint" id="errorEndDate">Please enter a valid end date</div>
                    </div>
                </div>
                
                <!-- Document Description -->
                <div class="form-group">
                    <label for="<%= txtDocumentDescription.ClientID %>">Document Description *</label>
                    <asp:TextBox ID="txtDocumentDescription" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" 
                        placeholder="Describe the supporting document (e.g., personal emergency letter, travel documents, etc.)..." 
                        MaxLength="500"></asp:TextBox>
                    <div class="error-hint" id="errorDocumentDescription">Please describe your supporting document</div>
                </div>
                 <br />
                 <br />
                
                <!-- File Name -->
                <div class="form-group">
                    <label for="<%= txtFileName.ClientID %>">File Name *</label>
                    <asp:TextBox ID="txtFileName" runat="server" CssClass="form-control" 
                        placeholder="e.g., unpaid_leave_request.pdf, emergency_document.jpg" 
                        MaxLength="100"></asp:TextBox>
                    <div class="error-hint" id="errorFileName">Please enter the document file name</div>
                </div>
                
                <!-- Submit Button -->
                <asp:Button ID="btnSubmit" runat="server" CssClass="submit-btn" 
                    Text="Submit Unpaid Leave Request" OnClick="btnSubmit_Click" 
                    OnClientClick="return validateForm();" />
                
                <!-- Message display -->
                <div class="message-container">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-box"></asp:Label>
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
                        var errorId = 'error' + this.id.replace('txt', '');
                        clearError(errorId);
                    });

                    control.addEventListener('blur', function () {
                        this.style.transform = 'translateY(0)';
                        this.style.boxShadow = 'none';
                    });
                });

                // Add change listeners to clear errors
                document.getElementById('<%= txtStartDate.ClientID %>').addEventListener('change', function () {
                    clearError('errorStartDate');
                });
                document.getElementById('<%= txtEndDate.ClientID %>').addEventListener('change', function () {
                    clearError('errorEndDate');
                });
                document.getElementById('<%= txtDocumentDescription.ClientID %>').addEventListener('input', function () {
                    clearError('errorDocumentDescription');
                });
                document.getElementById('<%= txtFileName.ClientID %>').addEventListener('input', function() {
                    clearError('errorFileName');
                });
                
                // Set default dates
                setDefaultDates();
                
                // Add character counters for text fields
                setupCharacterCounters();
            });
            
            function setDefaultDates() {
                var startDate = document.getElementById('<%= txtStartDate.ClientID %>');
                var endDate = document.getElementById('<%= txtEndDate.ClientID %>');
                
                if (startDate && !startDate.value) {
                    var today = new Date().toISOString().split('T')[0];
                    startDate.value = today;
                }
                
                if (endDate && !endDate.value) {
                    var nextWeek = new Date();
                    nextWeek.setDate(nextWeek.getDate() + 7);
                    endDate.value = nextWeek.toISOString().split('T')[0];
                }
            }
            
            function setupCharacterCounters() {
                // Document description counter
                var docDesc = document.getElementById('<%= txtDocumentDescription.ClientID %>');
                if (docDesc) {
                    var docDescCounter = document.createElement('div');
                    docDescCounter.className = 'char-counter';
                    docDescCounter.style.fontSize = '12px';
                    docDescCounter.style.color = '#6b7280';
                    docDescCounter.style.textAlign = 'right';
                    docDescCounter.style.marginTop = '5px';
                    docDesc.parentNode.insertBefore(docDescCounter, docDesc.nextSibling);
                    
                    docDesc.addEventListener('input', function() {
                        var remaining = 500 - this.value.length;
                        docDescCounter.textContent = remaining + ' characters remaining';
                        docDescCounter.style.color = remaining < 50 ? '#dc3545' : '#6b7280';
                    });
                    
                    // Trigger initial count
                    docDesc.dispatchEvent(new Event('input'));
                }
                
                // File name counter
                var fileName = document.getElementById('<%= txtFileName.ClientID %>');
                if (fileName) {
                    var fileNameCounter = document.createElement('div');
                    fileNameCounter.className = 'char-counter';
                    fileNameCounter.style.fontSize = '12px';
                    fileNameCounter.style.color = '#6b7280';
                    fileNameCounter.style.textAlign = 'right';
                    fileNameCounter.style.marginTop = '5px';
                    fileName.parentNode.insertBefore(fileNameCounter, fileName.nextSibling);
                    
                    fileName.addEventListener('input', function() {
                        var remaining = 100 - this.value.length;
                        fileNameCounter.textContent = remaining + ' characters remaining';
                        fileNameCounter.style.color = remaining < 20 ? '#dc3545' : '#6b7280';
                    });
                    
                    // Trigger initial count
                    fileName.dispatchEvent(new Event('input'));
                }
            }
            
            function styleMessages() {
                var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
                
                if (messageLabel) {
                    var messageText = messageLabel.textContent || messageLabel.innerText;
                    
                    if (messageText.trim() !== '') {
                        if (messageText.includes('✅') || messageText.includes('successfully') || 
                            messageText.includes('Success') || messageText.includes('Submitted')) {
                            messageLabel.className = 'message-box success-message';
                        } else if (messageText.includes('❌') || messageText.includes('Error') || 
                                   messageText.includes('Please') || messageText.includes('Required') ||
                                   messageText.includes('maximum') || messageText.includes('limit')) {
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
                var startDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
                if (!startDate) {
                    showError('txtStartDate', 'errorStartDate', 'Please enter a start date');
                    isValid = false;
                }
                
                // Validate End Date
                var endDate = document.getElementById('<%= txtEndDate.ClientID %>').value;
                if (!endDate) {
                    showError('txtEndDate', 'errorEndDate', 'Please enter an end date');
                    isValid = false;
                }
                
                // Date validation: End date should be after start date
                if (startDate && endDate) {
                    var start = new Date(startDate);
                    var end = new Date(endDate);
                    
                    if (end < start) {
                        showError('txtEndDate', 'errorEndDate', 'End date must be after start date');
                        isValid = false;
                    }
                    
                    // Check if leave duration exceeds 30 days
                    var timeDiff = Math.abs(end - start);
                    var dayDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end dates
                    
                    if (dayDiff > 30) {
                        showError('txtEndDate', 'errorEndDate', 'Unpaid leave cannot exceed 30 days. You requested ' + dayDiff + ' days.');
                        isValid = false;
                    }
                }
                
                // Validate Document Description
                var docDesc = document.getElementById('<%= txtDocumentDescription.ClientID %>').value;
                if (!docDesc.trim()) {
                    showError('txtDocumentDescription', 'errorDocumentDescription', 'Please describe your supporting document');
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