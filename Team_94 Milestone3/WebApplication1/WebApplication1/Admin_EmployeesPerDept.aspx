<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_EmployeesPerDept.aspx.cs" Inherits="WebApplication1.Admin_EmployeesPerDept" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employees per Department</title>
    <style>
        :root {
            --admin-color: #e74c3c;
            --admin-light: #ff6b6b;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --border: #e9ecef;
            --header-bg: #f8f9fa;
            --row-hover: #f8f9fa;
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, var(--admin-color), var(--admin-light));
            color: white;
            padding: 2rem;
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
            transform: translateX(-3px);
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
            padding: 2rem;
        }

        /* Chart Container */
        .chart-container {
            background: var(--header-bg);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            border: 1px solid var(--border);
        }

        .chart-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .chart-title i {
            color: var(--admin-color);
        }

        .chart-placeholder {
            height: 200px;
            background: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            font-size: 0.875rem;
            border: 1px dashed var(--border);
        }

        /* Table Styling */
        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid var(--border);
            background: white;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        .gridview thead {
            background: var(--header-bg);
        }

        .gridview th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-dark);
            border-bottom: 2px solid var(--border);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .gridview td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            color: var(--text-dark);
            font-size: 0.9375rem;
        }
        .gridview th:not(:last-child),
.gridview td:not(:last-child) {
    border-right: 1px solid var(--border);
}


        .gridview tbody tr {
            transition: all 0.2s ease;
        }

        .gridview tbody tr:hover {
            background: var(--row-hover);
        }

        .gridview tbody tr:last-child td {
            border-bottom: none;
        }
        .gridview tbody tr:first-child {
    background-color: rgba(231, 76, 60, 0.05);
    border-left: 3px solid var(--admin-color);
}

.gridview tbody tr:last-child td {
    border-bottom: none;
}

        /* Department badges */
        .dept-badge {
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
            display: inline-block;
        }

        /* Count styling */
        .count-high {
            color: #27ae60;
            font-weight: 600;
        }

        .count-medium {
            color: #f39c12;
            font-weight: 600;
        }

        .count-low {
            color: #e74c3c;
            font-weight: 600;
        }

        /* Summary stats */
        .summary-stats {
            display: flex;
            gap: 20px;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .summary-card {
            background: white;
            padding: 1.25rem;
            border-radius: 10px;
            border: 1px solid var(--border);
            min-width: 200px;
            flex: 1;
        }

        .summary-title {
            font-size: 0.875rem;
            color: var(--text-light);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .summary-value {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--admin-color);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .summary-stats {
                flex-direction: column;
            }
            
            .summary-card {
                min-width: 100%;
            }
            
            .content {
                padding: 1rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .page-title i {
                width: 40px;
                height: 40px;
                font-size: 1.25rem;
            }
            
            .header-actions {
                flex-direction: column;
                width: 100%;
            }
            
            .back-btn, .logout-btn {
                width: 100%;
                justify-content: center;
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
                        <i class="fas fa-chart-pie"></i>
                        Department Analytics
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
                <!-- Summary Statistics -->
                <div class="summary-stats">
                    <div class="summary-card">
                        <div class="summary-title">
                            <i class="fas fa-building"></i>
                            Total Departments
                        </div>
                        <div class="summary-value" id="totalDepts">0</div>
                    </div>
                    <div class="summary-card">
                        <div class="summary-title">
                            <i class="fas fa-users"></i>
                            Total Employees
                        </div>
                        <div class="summary-value" id="totalEmployees">0</div>
                    </div>

                </div>


                <!-- Department Table -->
                <div class="table-container">
                    <asp:GridView ID="gvDept" runat="server" AutoGenerateColumns="true"
                        CssClass="gridview" GridLines="None" />
                </div>
            </div>
        </div>
    </form>

    <script>
        // Update statistics based on table data
        document.addEventListener('DOMContentLoaded', function() {
            const table = document.getElementById('<%= gvDept.ClientID %>');
            if (table) {
                const rowCount = table.rows.length - 1; // Subtract header row
                document.getElementById('totalDepts').textContent = rowCount;
                
                // Calculate total employees and average
                let totalEmployees = 0;
                const rows = table.querySelectorAll('tbody tr');
                
                rows.forEach(row => {
                    const cells = row.cells;
                    if (cells.length >= 2) {
                        const countCell = cells[cells.length - 1]; // Last cell usually contains count
                        const count = parseInt(countCell.textContent) || 0;
                        totalEmployees += count;
                    }
                });
                
                document.getElementById('totalEmployees').textContent = totalEmployees;
                document.getElementById('avgPerDept').textContent = rowCount > 0 ? 
                    Math.round(totalEmployees / rowCount) : 0;
                
                // Add styling to count cells
                const countCells = table.querySelectorAll('td:last-child');
                countCells.forEach(cell => {
                    const count = parseInt(cell.textContent) || 0;
                    if (count >= 50) {
                        cell.className = 'count-high';
                    } else if (count >= 20) {
                        cell.className = 'count-medium';
                    } else if (count > 0) {
                        cell.className = 'count-low';
                    }
                });
                
                // Add department badges to first column
                const firstCells = table.querySelectorAll('td:first-child');
                firstCells.forEach(cell => {
                    cell.innerHTML = `<span class="dept-badge">${cell.textContent}</span>`;
                });
            }
            
            // Add alternating row colors
            const rows = document.querySelectorAll('.gridview tbody tr');
            rows.forEach((row, index) => {
                if (index % 2 === 0) {
                    row.style.backgroundColor = '#fcfcfc';
                }
            });
        });
    </script>
</body>
</html>