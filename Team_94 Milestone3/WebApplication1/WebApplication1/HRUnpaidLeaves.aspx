<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRUnpaidLeaves.aspx.cs" 
    Inherits="WebApplication1.HRUnpaidLeaves" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unpaid Leaves</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #5D8AA8 0%, #7A9EB1 50%, #98AFC7 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            padding: 30px;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #2ecc71;
        }

        .header-left h1 {
            color: #2c3e50;
            margin: 0;
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .back-btn {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.2);
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #2980b9, #1f6399);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(52, 152, 219, 0.3);
        }

        .logout-btn {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.2);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.3);
        }

        .section-title {
            color: #2c3e50;
            font-size: 22px;
            margin-top: 0;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title:before {
            content: "📅";
            font-size: 20px;
        }

        .gridview-container {
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid #ddd;
            margin-top: 20px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .gridview th {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            border: none;
        }

        .gridview td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
            background: white;
        }

        .gridview tr:hover td {
            background-color: #f5f5f5;
        }

        .action-button {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.2s;
            margin: 2px;
        }

        .action-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(52, 152, 219, 0.3);
        }

        .reject-button {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }

        .reject-button:hover {
            box-shadow: 0 3px 8px rgba(231, 76, 60, 0.3);
        }

        .approve-button {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
        }

        .approve-button:hover {
            box-shadow: 0 3px 8px rgba(46, 204, 113, 0.3);
        }

        /* Message label - for both success and error */
        .message-label {
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

        /* When message label is empty, make it invisible but still take space */
        .message-label:empty {
            color: transparent;
            background-color: white;
            border-color: transparent;
        }

        /* Success message styling - Green */
        .success-message {
            color: #27ae60;
            background-color: rgba(46, 204, 113, 0.1);
            border: 1px solid rgba(46, 204, 113, 0.2);
        }

        /* Error message styling - Red */
        .error-message {
            color: #e74c3c;
            background-color: rgba(231, 76, 60, 0.1);
            border: 1px solid rgba(231, 76, 60, 0.2);
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 16px;
        }

        html {
            scroll-behavior: smooth;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header Section -->
            <div class="header-section">
                <div class="header-left">
                    <h1>Pending Unpaid Leaves</h1>
                </div>
                <div style="display: flex; gap: 10px;">
                    <a href="HRHome.aspx" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                        OnClick="btnLogout_Click" CssClass="logout-btn" />
                </div>
            </div>

            <!-- Welcome Label -->
            <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-label" Text="" 
                style="color: #7f8c8d; font-size: 16px; display: block; margin-bottom: 20px;" />

            <!-- GridView Section -->
            <h3 class="section-title">Pending Requests</h3>
            
            <asp:Panel ID="pnlNoData" runat="server" CssClass="empty-message" Visible="false">
                <i class="fas fa-check-circle" style="font-size: 48px; color: #2ecc71; margin-bottom: 15px;"></i>
                <h3 style="color: #2c3e50; margin-bottom: 10px;">No Pending Leaves</h3>
                <p>There are no pending unpaid leave requests at this time.</p>
            </asp:Panel>

            <div class="gridview-container">
                <asp:GridView ID="gvUnpaid" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="request_ID" OnRowCommand="gvUnpaid_RowCommand"
                    CssClass="gridview" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="request_ID" HeaderText="Request ID" />
                        <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />
                        <asp:BoundField DataField="start_date" HeaderText="From" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="end_date" HeaderText="To" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="num_days" HeaderText="Days" />
                        <asp:ButtonField Text="Approve" CommandName="Approve" ButtonType="Button" 
                            ControlStyle-CssClass="action-button approve-button" />
                        <asp:ButtonField Text="Reject" CommandName="Reject" ButtonType="Button" 
                            ControlStyle-CssClass="action-button reject-button" />
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Label ID="lblStatus" runat="server" CssClass="message-label"></asp:Label>
        </div>
    </form>
</body>
</html>