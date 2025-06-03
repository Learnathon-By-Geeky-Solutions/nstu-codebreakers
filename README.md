# nstu-codebreakers

## Team Members
- Mahbub-Hasan-Talukder (Team Leader)
- 1Shishir
- Tahsin007

## Mentor
- chisty2996

## Project Description
# TASK-HIVE

A robust task management and project collaboration Flutter application with Supabase integration.


> **Download APK and View Screenshots**: 
https://drive.google.com/drive/folders/1zzEos7D048KUAY6uXgjOg2ztLIBnkE-0
## Overview

TASK-HIVE is a comprehensive project and task management solution that enables users to efficiently work on projects, track progress, and manage workloads. Built with Flutter and backed by Supabase, it offers a seamless experience across multiple platforms.

## Features

### Authentication Module

- **Secure Login System**:
  - Email/password authentication
  - Form validation with real-time feedback

- **Signup Process**:
  - Email verification
  - Password strength requirements
  - User profile creation

- **Password Recovery**:
  - Email-based recovery workflow
  - Secure token-based reset mechanism

### Project Dashboard

- **Project Management**:
  - Grid and list view options for projects
  - Project cards with progress indicators
  - Color-coded project categorization

- **Quick Actions**:
  - Create new project
  - Project analytics summary

### Task Management System

- **Task Board**:
  - Column-based task organization:
    - To-Do
    - In Progress
    - Done
    - Blocked

- **Task Details**:
  - Title and subtitle fields
  - Due date with reminder options
  - Priority levels (Low, Medium, High)
  - Custom labels and tags
  - Checklists for subtasks

- **Attachments**:
  - Multiple file uploads
  - Image previews
  - Storage quotas

### User Profile Management

- **Profile Features**:
  - Personal information management
  - Profile picture upload
  - Theme settings

## Technical Implementation

### Frontend Architecture

TASK-HIVE implements a clean architecture pattern with:

- **Presentation Layer**: Flutter UI components with Material Design 3 and with BLoC pattern for state management
- **Domain Layer**: Core business logic and models
- **Data Layer**: Repository pattern for data access

### Backend Integration

- **Supabase Integration**:
  - Real-time data synchronization
  - PostgreSQL database
  - Supabase Auth for authentication
  - Supabase Storage for file management


## Database Structure

TASK-HIVE uses the following Supabase tables:

- **Users**: Stores user profiles and authentication data
- **Projects**: Contains project metadata and ownership information
- **Tasks**: Manages task details including status, priority, and due dates
- **Task Assignees**: Tracks the assignment of tasks to team members
- **Attachments**: Stores file metadata for task attachments

## Project Structure

The project follows a modular structure:

- **Core**: Configuration, constants, utilities, and error handling
- **Data**: Models, repositories, and data sources
- **Domain**: Business logic, entities, and use cases
- **Presentation**: UI components, screens, and state management
  - **Authentication Screens**: Login, signup, password recovery
  - **Dashboard**: Project overview and management
  - **Project Screens**: Task board and project details
  - **Task Management**: Task creation and editing
  - **Profile**: User profile management

## Dependencies

Key Flutter packages used:

- **State Management**: flutter_bloc, equatable
- **Supabase**: supabase_flutter
- **Forms**: form_field_validator
- **Utilities**: intl, flutter_dotenv, logger
- **File Handling**: path_provider, file_picker

