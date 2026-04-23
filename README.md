# University HR Management System - Team 94

A comprehensive ASP.NET web application for managing human resources in a university setting. This system provides functionality for administrators, HR employees, and academic staff to manage employee information, attendance, leave requests, payroll, and performance evaluations.

## Project Overview

The University HR Management System is a three-milestone project that implements:

- **Milestone 1**: Enhanced Entity-Relationship Diagram (EERD) and database schema design
- **Milestone 2**: SQL Server database implementation with stored procedures, functions, and views
- **Milestone 3**: ASP.NET web application with complete user interface and business logic

Milestones 1,2 were team work while Milestone 3 was done individualy

The system centralizes employee information, streamlines HR operations, and automates workflows for leave approvals, payroll generation, and performance monitoring across the university.

## System Architecture

### Technology Stack

- **Backend**: ASP.NET (C#)
- **Database**: SQL Server
- **Frontend**: ASP.NET Web Forms with HTML/CSS
- **Programming Language**: C# (.NET Framework)

### Key Components

**Three Main User Roles:**

1. **Admin Component** - University administrators with system-wide control
2. **Academic Employee Component** - Faculty and staff members
3. **HR Employee Component** - HR department staff managing approvals and payroll

## Getting Started

### Prerequisites

- Windows environment with Visual Studio
- SQL Server 2012 or later
- .NET Framework 4.5 or higher
- ASP.NET Web Forms support

### Installation & Setup

1. **Extract the project**:
   ```
   Extract Team_94_Milestone3.zip
   ```

2. **Set up the database**:
   - Open SQL Server Management Studio
   - Execute `final_implementation.sql` to create and populate the database
   - Database name: `University_HR_ManagementSystem_Team_94`

3. **Open the project in Visual Studio**:
   - Open `WebApplication1.sln`
   - Build the solution (Ctrl+Shift+B)

4. **Configure database connection**:
   - Update the connection string in `Web.config` if needed
   - Ensure SQL Server is running and accessible

5. **Run the application**:
   - Press F5 or click Start to launch the web application
   - Opens in default browser at `http://localhost:[port]/`


### Employee Component - Part 1 (My Implementation)

MY part handles the following employee functionalities:

**Functionalities:**
1. **Login**: Authenticate using employee ID and password
2. **View Performance**: Retrieve personal performance evaluation for a specific semester
3. **View Attendance**: Retrieve attendance records for current month (excluding unattended official day-off)
4. **View Payroll**: Retrieve and view last month's payroll details
5. **View Deductions**: Fetch all attendance-related deductions for a specified period
6. **Apply for Annual Leave**: Submit annual leave request with replacement employee designation
7. **Check Leave Status**: View status of all submitted annual and accidental leaves during current month

**Related Pages Implemented:**
- `Login.aspx` - Employee login authentication
- `Dashboard.aspx` - Employee dashboard/home
- `Performance.aspx` - Performance view by semester
- `Attendance.aspx` - Current month attendance records
- `Payroll.aspx` - Last month payroll display
- `Deductions.aspx` - Attendance deduction details
- `AnnualLeave.aspx` - Annual leave application form
- `LeaveStatus.aspx` - Check submitted leave request status


### Login

**Admin Login:**
- Navigate to Admin Login page
- Default credentials (hardcoded):
  - Username: Admin ID
  - Password: [as configured]

**Employee Login:**
- Navigate to Employee Login page
- Enter your Employee ID and Password from database
ID: 1
Password: 123

**HR Login:**
- Navigate to HR Login page
- Enter your HR Employee ID and Password from database


## Project Structure & Team

**Three Main Components:**

1. **Admin Component** (2 parts)
   - Part 1: Employee management, holidays, attendance
   - Part 2: Advanced attendance management, replacements, status updates

2. **Academic Employee Component** (2 parts)
   - **Part 1**: Personal info, performance, attendance, payroll, leave status ← **My Part**
   - Part 2: Leave applications, approvals, evaluations

3. **HR Employee Component** (1 part)
   - Leave approvals, deductions, payroll generation

**Integration Grade:**
All components must be integrated into a cohesive, navigable website with proper linking between modules.

## Testing

The application includes:
- Input validation on all forms
- Error messages for invalid actions
- Success notifications for completed actions
- Data consistency checks
- Leave balance verification

## Documentation

- **Milestone 1**: EERD and database schema design
- **Milestone 2**: SQL implementation with procedures and functions
- **Milestone 3**: Web application implementation (this deliverable)
- **Team Details PDF**: `Team_94 Details.pdf` - Team member information
- **SQL Script**: `final_implementation.sql` - Complete database setup

## Author

**Team 94** - Database I Course Project
German University in Cairo
Media Engineering and Technology

## License

Academic Use Only - Course Project


