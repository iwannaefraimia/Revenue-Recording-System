# Revenue Recording System for the Ministry of Economy

## Overview

This project, titled **Revenue Recording System**, was developed as part of the "Information Systems Development & Architectures" course at the Athens University of Economics and Business (AUEB). It aims to support the Ministry of Economy by facilitating the transition to the integrated revenue system of the General Secretariat of Public Revenue Digital Governance. The system improves the ministry's digital infrastructure and provides tools for efficient account and income type management.

## Features

- **Account and Income Type Management**:
  - CRUD (Create, Read, Update, Delete) operations for user accounts and income types.
- **Database Integration**:
  - Fully implemented using SQL databases to ensure robust and scalable data storage.
- **Model-View-Controller (MVC) Architecture**:
  - Implements the MVC pattern to separate application logic, user interface, and database interactions.
- **Web-Based Application**:
  - Developed using Java Server Pages (JSP) for dynamic and interactive user interfaces.

## Technologies Used

- **Languages**: Java (backend), JSP (frontend)
- **Database**: SQL
- **Frameworks and Tools**:
  - Eclipse/IntelliJ IDEA for development
  - Apache Tomcat as the application server
  - GitHub for version control

## Project Structure

- **JSP Directory**:
  - Contains the frontend files, including forms and web pages for user interaction.
  - Subfolders for organized assets such as CSS, JavaScript, and images.
- **Java Directory**:
  - Includes backend logic, service classes, and models to support the application.
- **SQL_backup.sql**:
  - A backup of the SQL database schema and initial data for deployment or recovery.

## Setup Instructions

1. **Database Setup**:
   - Import the `SQL_backup.sql` file into your database server (e.g., MySQL or PostgreSQL).
   - Update the database connection details in the Java configuration files.

2. **Application Deployment**:
   - Install and configure Apache Tomcat or another compatible server.
   - Deploy the project files to the server.

3. **Run the Application**:
   - Access the application through the server's provided URL (e.g., `http://localhost:8080/RevenueSystem`).

## Contributions

This project was a collaborative effort, designed and implemented by a team of students to address real-world challenges faced by the Ministry of Economy.

---
