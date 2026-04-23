<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dean_andHR_Evaluation.aspx.cs" Inherits="WebApplication1.Dean_andHR_Evaluation" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Evaluate Employees</title>
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
        
        /* BIGGER EMPLOYEE DROPDOWN */
        .employee-dropdown {
            font-size: 18px !important;
            padding: 16px !important;
            height: auto !important;
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
        
        /* STAR RATING STYLES */
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 8px;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            cursor: pointer;
            font-size: 40px;
            color: #e5e7eb;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .star-rating label:before {
            content: '★';
        }
        
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #FFD700;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
        }
        
        .star-rating input:checked + label:hover,
        .star-rating input:checked + label:hover ~ label,
        .star-rating input:checked ~ label:hover,
        .star-rating input:checked ~ label:hover ~ label,
        .star-rating label:hover ~ input:checked ~ label {
            color: #FFED85;
        }
        
        .rating-value {
            margin-left: 15px;
            font-size: 18px;
            font-weight: 600;
            color: #1e3a8a;
            min-width: 60px;
            display: inline-block;
        }
        
        .rating-text {
            margin-left: 10px;
            font-size: 16px;
            color: #6b7280;
            font-style: italic;
        }
        
        .rating-container {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        
        .note-box {
            background: linear-gradient(135deg, #e8f4fd 0%, #d1e9ff 100%);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 40px;
            border-left: 4px solid #1e3a8a;
            font-size: 16px;
            color: #1e3a8a;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .note-box strong {
            color: #1e3a8a;
            font-size: 17px;
        }
        
        /* SUBMIT BUTTON - MATCHING BACK BUTTON COLOR */
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
            
            .star-rating label {
                font-size: 36px;
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
            
            .employee-dropdown {
                font-size: 16px !important;
                padding: 14px !important;
            }
            
            .star-rating label {
                font-size: 32px;
            }
            
            .rating-container {
                flex-direction: column;
                align-items: flex-start;
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
            
            .employee-dropdown {
                font-size: 15px !important;
                padding: 12px !important;
            }
            
            .star-rating label {
                font-size: 28px;
            }
            
            .rating-value {
                font-size: 16px;
            }
            
            .rating-text {
                font-size: 14px;
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
                <h1>Employee Evaluation</h1>
                <p>As a Dean/HR, evaluate employees within your department. All fields marked with * are required.</p>
            </div>
            
            <!-- Note box -->
            <div class="note-box">
                <strong>Important Note:</strong> As a Dean or HR representative, you can evaluate employees within the same department. Please provide fair and constructive feedback.
            </div>
            
            <!-- FORM CARD -->
            <div class="form-card">
                <!-- Employee Selection -->
                <div class="form-group">
                    <label for="<%= ddlEmployee.ClientID %>" id="lblEmployee">Select Employee *</label>
                    <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control employee-dropdown">
                        <asp:ListItem Value="">-- Select Employee --</asp:ListItem>
                    </asp:DropDownList>
                    <div class="error-hint" id="errorEmployee">Please select an employee to evaluate</div>
                </div>
                 <br />
                 <br />
                
                <!-- STAR RATING -->
                <div class="form-group">
                    <label id="lblRating">Rating (1-5) *</label>
                    <div class="rating-container">
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5" />
                            <label for="star5" title="5 stars"></label>
                            <input type="radio" id="star4" name="rating" value="4" />
                            <label for="star4" title="4 stars"></label>
                            <input type="radio" id="star3" name="rating" value="3" checked="checked" />
                            <label for="star3" title="3 stars"></label>
                            <input type="radio" id="star2" name="rating" value="2" />
                            <label for="star2" title="2 stars"></label>
                            <input type="radio" id="star1" name="rating" value="1" />
                            <label for="star1" title="1 star"></label>
                        </div>
                        <div class="rating-value" id="ratingValue">3</div>
                        <div class="rating-text" id="ratingText">Good</div>
                    </div>
                    <div class="error-hint" id="errorRating">Please select a rating</div>
                    <!-- Hidden field to store rating for server-side -->
                    <asp:HiddenField ID="hdnRating" runat="server" Value="3" />
                </div>
                 <br />
                 <br />
                
                <!-- Comments -->
                <div class="form-group">
                    <label for="<%= txtComments.ClientID %>">Comments</label>
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" 
                        placeholder="Enter your evaluation comments... (Provide constructive feedback on performance, areas of improvement, and strengths)"></asp:TextBox>
                </div>
                
                <!-- Semester -->
                <div class="form-group">
                    <label for="<%= ddlSemester.ClientID %>" id="lblSemester">Semester *</label>
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Semester --</asp:ListItem>
                        <asp:ListItem Value="W25">Winter 2025</asp:ListItem>
                        <asp:ListItem Value="S25">Spring 2025</asp:ListItem>
                        <asp:ListItem Value="F24">Fall 2024</asp:ListItem>
                        <asp:ListItem Value="S24">Spring 2024</asp:ListItem>
                        <asp:ListItem Value="W24">Winter 2024</asp:ListItem>
                    </asp:DropDownList>
                    <div class="error-hint" id="errorSemester">Please select a semester</div>
                </div>
                 <br />
                 <br />
                
                <!-- Submit Button - MATCHING BACK BUTTON COLOR -->
                <asp:Button ID="btnSubmit" runat="server" CssClass="submit-btn" 
                    Text="Submit Evaluation" OnClick="btnSubmit_Click" 
                    OnClientClick="return validateForm();" />
                
                <!-- Message display -->
                <div class="message-container">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-box"></asp:Label>
                </div>
            </div>
        </div>
        
        <!-- JavaScript to handle validation, message styling, and star rating -->
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
                        var errorId = 'error' + this.id.replace('ddl', '').replace('txt', '');
                        clearError(errorId);
                    });

                    control.addEventListener('blur', function () {
                        this.style.transform = 'translateY(0)';
                        this.style.boxShadow = 'none';
                    });
                });

                // Add change listeners to clear errors
                document.getElementById('<%= ddlEmployee.ClientID %>').addEventListener('change', function () {
                    clearError('errorEmployee');
                });
                document.getElementById('<%= txtComments.ClientID %>').addEventListener('input', function () {
                    // No error for comments as it's optional
                });
                document.getElementById('<%= ddlSemester.ClientID %>').addEventListener('change', function () {
                    clearError('errorSemester');
                });
                
                // Setup star rating system
                setupStarRating();
                
                // Set default semester if not set
                setDefaultSemester();
            });
            
            function setupStarRating() {
                const stars = document.querySelectorAll('.star-rating input');
                const ratingValue = document.getElementById('ratingValue');
                const ratingText = document.getElementById('ratingText');
                const hiddenField = document.getElementById('<%= hdnRating.ClientID %>');
                
                // Rating text descriptions
                const ratingDescriptions = {
                    '1': 'Poor',
                    '2': 'Fair',
                    '3': 'Good',
                    '4': 'Very Good',
                    '5': 'Excellent'
                };
                
                // Function to update rating display
                function updateRating(value) {
                    ratingValue.textContent = value;
                    ratingText.textContent = ratingDescriptions[value];
                    hiddenField.value = value;
                    clearError('errorRating');
                }
                
                // Add event listeners to stars
                stars.forEach(star => {
                    star.addEventListener('change', function() {
                        updateRating(this.value);
                    });
                    
                    star.addEventListener('mouseover', function() {
                        // Highlight stars on hover
                        const value = this.value;
                        stars.forEach(s => {
                            const label = document.querySelector(`label[for="${s.id}"]`);
                            if (s.value <= value) {
                                label.style.color = '#FFD700';
                                label.style.textShadow = '0 0 10px rgba(255, 215, 0, 0.5)';
                            } else {
                                label.style.color = '#e5e7eb';
                                label.style.textShadow = 'none';
                            }
                        });
                    });
                });
                
                // Add mouseleave event to restore selected state
                const starContainer = document.querySelector('.star-rating');
                starContainer.addEventListener('mouseleave', function() {
                    const selectedStar = document.querySelector('.star-rating input:checked');
                    if (selectedStar) {
                        const value = selectedStar.value;
                        stars.forEach(s => {
                            const label = document.querySelector(`label[for="${s.id}"]`);
                            if (s.value <= value) {
                                label.style.color = '#FFD700';
                                label.style.textShadow = '0 0 10px rgba(255, 215, 0, 0.5)';
                            } else {
                                label.style.color = '#e5e7eb';
                                label.style.textShadow = 'none';
                            }
                        });
                    } else {
                        // If no star is selected, show default (3 stars)
                        stars.forEach(s => {
                            const label = document.querySelector(`label[for="${s.id}"]`);
                            if (s.value <= 3) {
                                label.style.color = '#FFD700';
                                label.style.textShadow = '0 0 10px rgba(255, 215, 0, 0.5)';
                            } else {
                                label.style.color = '#e5e7eb';
                                label.style.textShadow = 'none';
                            }
                        });
                    }
                });
                
                // Initialize with default 3 stars
                updateRating('3');
            }
            
            function setDefaultSemester() {
                var semesterDropdown = document.getElementById('<%= ddlSemester.ClientID %>');
                if (semesterDropdown && !semesterDropdown.value) {
                    // Set current semester based on current date
                    var today = new Date();
                    var month = today.getMonth() + 1; // January is 0
                    var year = today.getFullYear().toString().substring(2);
                    
                    var semester;
                    if (month >= 1 && month <= 4) {
                        semester = 'W' + year; // Winter
                    } else if (month >= 5 && month <= 8) {
                        semester = 'S' + year; // Spring
                    } else {
                        semester = 'F' + year; // Fall
                    }
                    
                    // Try to find and select the current semester
                    for (var i = 0; i < semesterDropdown.options.length; i++) {
                        if (semesterDropdown.options[i].value === semester) {
                            semesterDropdown.value = semester;
                            break;
                        }
                    }
                }
            }
            
            function styleMessages() {
                var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
                
                if (messageLabel) {
                    var messageText = messageLabel.textContent || messageLabel.innerText;
                    
                    if (messageText.trim() !== '') {
                        if (messageText.includes('✅') || messageText.includes('successfully') || 
                            messageText.includes('Success') || messageText.includes('Submitted') || 
                            messageText.includes('Evaluation submitted')) {
                            messageLabel.className = 'message-box success-message';
                        } else if (messageText.includes('❌') || messageText.includes('Error') || 
                                   messageText.includes('Please') || messageText.includes('Required') ||
                                   messageText.includes('failed')) {
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
                
                // Validate Employee Selection
                var employee = document.getElementById('<%= ddlEmployee.ClientID %>').value;
                if (!employee) {
                    showError('ddlEmployee', 'errorEmployee', 'Please select an employee to evaluate');
                    isValid = false;
                }
                
                // Validate Rating - check if a star is selected
                var hiddenField = document.getElementById('<%= hdnRating.ClientID %>');
                if (!hiddenField || !hiddenField.value) {
                    showError('star-rating', 'errorRating', 'Please select a rating');
                    isValid = false;
                }
                
                // Validate Semester
                var semester = document.getElementById('<%= ddlSemester.ClientID %>').value;
                if (!semester) {
                    showError('ddlSemester', 'errorSemester', 'Please select a semester');
                    isValid = false;
                }

                // If invalid, scroll to first error
                if (!isValid) {
                    var firstError = document.querySelector('.error-field') || document.querySelector('#errorRating');
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
                        setupStarRating();
                    });
                }
            };
        </script>
    </form>
</body>
</html>