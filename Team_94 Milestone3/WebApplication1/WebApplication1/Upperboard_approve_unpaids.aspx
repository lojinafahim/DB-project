<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upperboard_approve_unpaids.aspx.cs" Inherits="WebApplication1.ApproveUnpaidLeaves" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Approve/Reject Unpaid Leaves</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* RESET AND BASE STYLES */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html, body {
            height: 100%;
            width: 100%;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            overflow-x: hidden;
        }
        
        /* FORM CONTAINER - FIXED TO CENTER */
        #form1 {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            width: 100%;
        }
        
        /* MAIN CONTAINER - CENTERED */
        .main-container {
            width: 100%;
            max-width: 1400px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 40px;
            margin: 0 auto; /* THIS CENTERS THE CONTAINER */
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
            text-decoration: none;
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
        
        /* CONTENT CARD */
        .content-card {
            background: white;
            border-radius: 18px;
            padding: 40px;
            border: 2px solid #e5e7eb;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        
        /* GRIDVIEW STYLES */
        .gridview-container {
            width: 100%;
            overflow-x: auto;
            margin: 20px 0;
        }
        
        .styled-gridview {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }
        
        .styled-gridview th {
            background: linear-gradient(135deg, #1e3a8a 0%, #5D8AA8 100%);
            color: white;
            font-weight: 600;
            text-align: left;
            padding: 16px;
            font-size: 16px;
            border: none;
        }
        
        .styled-gridview td {
            padding: 14px 16px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 15px;
            color: #374151;
        }
        
        .styled-gridview tr:hover {
            background-color: #f8fafc;
        }
        
        .styled-gridview tr:nth-child(even) {
            background-color: #f9fafb;
        }
        
        .styled-gridview tr:nth-child(even):hover {
            background-color: #f3f4f6;
        }
        
        /* ACTION BUTTONS */
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .btn-approve {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-approve:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.3);
            background: linear-gradient(135deg, #218838 0%, #1c7430 100%);
        }
        
        .btn-reject {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-reject:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(220, 53, 69, 0.3);
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }
        
        /* STATUS BADGES */
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            min-width: 80px;
        }
        
        .status-pending {
            background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            color: #856404;
            border: 1px solid #ffc107;
        }
        
        .status-approved {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border: 1px solid #28a745;
        }
        
        .status-rejected {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border: 1px solid #dc3545;
        }
        
        /* MESSAGE STYLES */
        .message-container {
            margin-top: 25px;
            min-height: 70px;
            position: relative;
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
        
        /* NOTE BOX */
        .note-box {
            background: linear-gradient(135deg, #e8f4fd 0%, #d1e9ff 100%);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 40px;
            border-left: 4px solid #1e3a8a;
            font-size: 16px;
            color: #1e3a8a;
        }
        
        .note-box strong {
            color: #1e3a8a;
            font-size: 17px;
        }
        
        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6b7280;
        }
        
        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .empty-state-text {
            font-size: 18px;
            font-weight: 500;
        }
        
        /* RESPONSIVE */
        @media (max-width: 1400px) {
            .main-container {
                max-width: 95%;
            }
        }
        
        @media (max-width: 1024px) {
            .main-container {
                padding: 30px;
                max-width: 98%;
            }
            
            .content-card {
                padding: 30px;
            }
            
            .styled-gridview {
                min-width: 900px;
            }
        }
        
        @media (max-width: 768px) {
            #form1 {
                padding: 10px;
            }
            
            .main-container {
                padding: 20px;
                max-width: 100%;
            }
            
            .header h1 {
                font-size: 36px;
            }
            
            .content-card {
                padding: 20px;
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
            
            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }
            
            .btn-approve, .btn-reject {
                width: 100%;
                text-align: center;
            }
        }
        
        @media (max-width: 480px) {
            .main-container {
                padding: 15px;
                border-radius: 16px;
            }
            
            .header h1 {
                font-size: 32px;
            }
            
            .content-card {
                padding: 15px;
                border-radius: 12px;
            }
            
            .styled-gridview th,
            .styled-gridview td {
                padding: 12px;
                font-size: 14px;
            }
            
            .note-box {
                padding: 20px;
            }
            
            .message-box {
                padding: 15px;
                font-size: 15px;
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
                <h1>Approve/Reject Unpaid Leaves</h1>
                <p>Review and manage unpaid leave requests from employees. Approve or reject requests based on departmental needs and policies.</p>
            </div>
            
            <!-- Note box -->
            <div class="note-box">
                <strong>Important Note:</strong> As an Upper Board member, you have the authority to approve or reject unpaid leave requests. Please review each request carefully considering workload, departmental impact, and urgency.
            </div>
            
            <!-- CONTENT CARD -->
            <div class="content-card">
                <div class="gridview-container">
                    <asp:GridView ID="gvUnpaidLeaves" runat="server" AutoGenerateColumns="false" 
                        CssClass="styled-gridview" OnRowCommand="gvUnpaidLeaves_RowCommand" 
                        DataKeyNames="request_ID" ShowHeaderWhenEmpty="true"
                        EmptyDataText="No unpaid leave requests pending approval.">
                        <Columns>
                            <asp:BoundField DataField="request_ID" HeaderText="Request ID" 
                                ItemStyle-CssClass="font-semibold" />
                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                            <asp:BoundField DataField="dept_name" HeaderText="Department" />
                            <asp:BoundField DataField="start_date" HeaderText="Start Date" 
                                DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="end_date" HeaderText="End Date" 
                                DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="Days" HeaderText="Days" 
                                ItemStyle-CssClass="text-center" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" 
                                        CssClass='<%# GetStatusClass(Eval("final_approval_status").ToString()) %>'
                                        Text='<%# Eval("final_approval_status") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="action-buttons">
                                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="Approve" 
                                            CommandArgument='<%# Eval("request_ID") %>' 
                                            CssClass="btn-approve" />
                                        <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="Reject" 
                                            CommandArgument='<%# Eval("request_ID") %>' 
                                            CssClass="btn-reject" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                
                <!-- Message display -->
                <div class="message-container">
                    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-box"></asp:Panel>
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-box"></asp:Label>
                </div>
            </div>
        </div>
        
        <!-- JavaScript to handle message styling -->
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
                
                // Add hover effects to table rows
                var tableRows = document.querySelectorAll('.styled-gridview tr');
                tableRows.forEach(function(row) {
                    row.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateY(-2px)';
                        this.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.05)';
                    });
                    
                    row.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateY(0)';
                        this.style.boxShadow = 'none';
                    });
                });
                
                // Add confirmation dialogs for approve/reject actions
                var approveButtons = document.querySelectorAll('.btn-approve');
                approveButtons.forEach(function(button) {
                    button.addEventListener('click', function(e) {
                        if (!confirm('Are you sure you want to approve this unpaid leave request?')) {
                            e.preventDefault();
                            return false;
                        }
                    });
                });
                
                var rejectButtons = document.querySelectorAll('.btn-reject');
                rejectButtons.forEach(function(button) {
                    button.addEventListener('click', function(e) {
                        if (!confirm('Are you sure you want to reject this unpaid leave request?')) {
                            e.preventDefault();
                            return false;
                        }
                    });
                });
            });
            
            function styleMessages() {
                var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
                var messagePanel = document.getElementById('<%= pnlMessage.ClientID %>');

                // First check panel
                if (messagePanel && messagePanel.style.display !== 'none') {
                    var messageText = messagePanel.textContent || messagePanel.innerText;

                    if (messageText.trim() !== '') {
                        if (messageText.includes('✅') || messageText.includes('approved') ||
                            messageText.includes('successfully') || messageText.includes('Success') ||
                            messageText.includes('Approved')) {
                            messagePanel.className = 'message-box success-message';
                        } else if (messageText.includes('❌') || messageText.includes('rejected') ||
                            messageText.includes('Error') || messageText.includes('failed') ||
                            messageText.includes('Please')) {
                            messagePanel.className = 'message-box error-message';
                        } else {
                            messagePanel.className = 'message-box info-message';
                        }

                        // Scroll to message container smoothly
                        var messageContainer = messagePanel.closest('.message-container');
                        if (messageContainer) {
                            setTimeout(function () {
                                messageContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }, 100);
                        }
                    }
                }

                // Then check label
                if (messageLabel) {
                    var messageText = messageLabel.textContent || messageLabel.innerText;

                    if (messageText.trim() !== '') {
                        if (messageText.includes('✅') || messageText.includes('approved') ||
                            messageText.includes('successfully') || messageText.includes('Success') ||
                            messageText.includes('Approved')) {
                            messageLabel.className = 'message-box success-message';
                        } else if (messageText.includes('❌') || messageText.includes('rejected') ||
                            messageText.includes('Error') || messageText.includes('failed') ||
                            messageText.includes('Please')) {
                            messageLabel.className = 'message-box error-message';
                        } else {
                            messageLabel.className = 'message-box info-message';
                        }

                        // Scroll to message container smoothly
                        var messageContainer = messageLabel.closest('.message-container');
                        if (messageContainer) {
                            setTimeout(function () {
                                messageContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }, 100);
                        }
                    }
                }
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