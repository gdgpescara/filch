# Staff Package

Staff management package providing functionality for event staff including shift management, point assignment, and administrative tools.

## Data Models

### Shift

Staff shift information:

```dart
class Shift extends Equatable {
  final FirestoreUser user;           // Staff member
  final DateTime start;               // Shift start time
  final int duration;                 // Shift duration in minutes
  final ShiftLocationsEnum location;  // Shift location
  final String notes;                 // Additional notes
}
```

### FirestoreUser

User information for staff members:

```dart
class FirestoreUser extends Equatable {
  final String uid;                   // User ID
  final String? displayName;          // Display name
  final String email;                 // Email address
  final String photoUrl;              // Profile photo URL
}
```

### ShiftLocationsEnum

Available shift locations:

- `registration` - Registration desk
- `catering` - Catering area
- `mainStage` - Main stage area
- `secondaryStage` - Secondary stage area
- `workshops` - Workshop rooms
- `networking` - Networking area
- `sponsors` - Sponsor area
- `info` - Information desk

## Use Cases

### Shift Management

- **GetStaffShiftsUseCase** - Get all staff shifts
- **GetUserShiftsUseCase** - Get shifts for specific user
- **CreateShiftUseCase** - Create new shift assignment
- **UpdateShiftUseCase** - Update existing shift
- **DeleteShiftUseCase** - Delete shift assignment
- **GetShiftsByLocationUseCase** - Get shifts by location
- **GetShiftsByDateUseCase** - Get shifts for specific date

### Staff Administration

- **GetStaffUsersUseCase** - Get all staff members
- **AssignStaffRoleUseCase** - Assign staff role to user
- **RemoveStaffRoleUseCase** - Remove staff role from user
- **GetStaffPermissionsUseCase** - Get staff member permissions

### Point Assignment (Staff Tools)

- **AssignPointsToUsersUseCase** - Assign points to multiple users
- **GetAssignablePointTypesUseCase** - Get available point types
- **BulkPointAssignmentUseCase** - Bulk assign points
- **GetPointAssignmentHistoryUseCase** - Get point assignment history

### Reporting

- **GetStaffReportUseCase** - Generate staff activity report
- **GetShiftCoverageReportUseCase** - Get shift coverage statistics
- **ExportStaffDataUseCase** - Export staff data

## State Management

### StaffBloc

Manages staff-related state.

#### Staff States

- **StaffInitial** - Initial state
- **StaffLoading** - Loading staff data
- **StaffLoaded** - Staff data loaded
- **StaffError** - Error loading staff data

#### Staff Events

- **StaffLoadRequested** - Load staff data
- **ShiftCreateRequested** - Create new shift
- **ShiftUpdateRequested** - Update shift
- **ShiftDeleteRequested** - Delete shift

### ShiftBloc

Manages shift scheduling state.

#### Shift States

- **ShiftInitial** - Initial state
- **ShiftLoading** - Loading shifts
- **ShiftLoaded** - Shifts loaded
- **ShiftError** - Error loading shifts

#### Shift Events

- **ShiftLoadRequested** - Load shifts
- **ShiftFilterChanged** - Change shift filters
- **ShiftRefreshRequested** - Refresh shift data

## Widgets

### StaffShiftList

Display list of staff shifts with filtering options.

```dart
StaffShiftList(
  shifts: shifts,
  onShiftTap: (shift) => editShift(shift),
  filterByLocation: ShiftLocationsEnum.mainStage,
  filterByDate: DateTime.now(),
)
```

### ShiftCreationForm

Form for creating/editing shifts.

```dart
ShiftCreationForm(
  initialShift: existingShift,
  staffMembers: availableStaff,
  onSubmit: (shift) => createShift(shift),
)
```

### PointAssignmentTool

Tool for staff to assign points to users.

```dart
PointAssignmentTool(
  selectedUsers: selectedUsers,
  availablePointTypes: pointTypes,
  onAssignPoints: (users, points, type) => assignPoints(users, points, type),
)
```

### StaffDashboard

Dashboard showing staff statistics and quick actions.

```dart
StaffDashboard(
  totalShifts: staffStats.totalShifts,
  upcomingShifts: staffStats.upcomingShifts,
  pointsAssigned: staffStats.pointsAssigned,
  onQuickAction: (action) => handleAction(action),
)
```

## Firebase Collections

### shifts

Staff shifts collection:

```dart
{
  "id": "shift_id",
  "user": {
    "uid": "staff_user_id",
    "displayName": "Staff Member Name",
    "email": "staff@example.com",
    "photoUrl": "photo_url"
  },
  "start": Timestamp,
  "duration": 240, // minutes
  "location": "registration|catering|mainStage|...",
  "notes": "Additional shift notes",
  "createdAt": Timestamp,
  "createdBy": "admin_user_id",
  "status": "scheduled|active|completed|cancelled"
}
```

### staffUsers

Staff user permissions:

```dart
{
  "uid": "user_id",
  "role": "admin|staff|volunteer",
  "permissions": [
    "assign_points",
    "manage_shifts", 
    "view_reports",
    "manage_quests"
  ],
  "assignedAt": Timestamp,
  "assignedBy": "admin_user_id",
  "isActive": boolean
}
```

### pointAssignments

Point assignment history (for auditing):

```dart
{
  "id": "assignment_id",
  "assignedBy": "staff_user_id",
  "assignedTo": ["user_id1", "user_id2"],
  "pointType": "staff|community",
  "points": 50,
  "reason": "Assignment reason",
  "assignedAt": Timestamp,
  "quest": "quest_id" // optional
}
```

## Firebase Functions

### assignShift

Assign shift to staff member.

**Request:**

```json
{
  "userId": "staff_user_id",
  "start": "2024-11-09T10:00:00Z",
  "duration": 240,
  "location": "registration",
  "notes": "Morning registration shift"
}
```

**Response:**

```json
{
  "success": true,
  "shiftId": "shift_123",
  "message": "Shift assigned successfully"
}
```

### bulkAssignPoints

Assign points to multiple users (staff only).

**Request:**

```json
{
  "userIds": ["user1", "user2", "user3"],
  "pointType": "staff",
  "points": 50,
  "reason": "Excellent participation"
}
```

**Response:**

```json
{
  "success": true,
  "usersUpdated": 3,
  "assignmentId": "assignment_456"
}
```

### getStaffReport

Generate staff activity report.

**Request:**

```json
{
  "startDate": "2024-11-09T00:00:00Z",
  "endDate": "2024-11-10T23:59:59Z",
  "includePointAssignments": true
}
```

**Response:**

```json
{
  "success": true,
  "report": {
    "totalShifts": 45,
    "totalHours": 180,
    "pointsAssigned": 2500,
    "staffMembers": 12,
    "shiftsByLocation": {
      "registration": 15,
      "catering": 10,
      "mainStage": 20
    }
  }
}
```

## Features

### Implemented Functionality

- Staff shift scheduling and management
- Point assignment tools for staff
- Staff role and permission management
- Shift coverage tracking
- Staff activity reporting
- Bulk operations for point assignment
- Real-time shift updates
- Staff dashboard with statistics

### Exported Functionality

- Shift management use cases
- Staff administration use cases
- Point assignment use cases
- Staff reporting use cases
- Staff state management (Bloc)
- Staff-specific widgets
- Staff data models

### Administrative Tools

- Shift scheduling interface
- Point assignment interface
- Staff member management
- Activity monitoring
- Report generation
- Bulk operations

## Security & Permissions

### Role-Based Access

- **Admin** - Full access to all staff functions
- **Staff** - Can assign points, view shifts
- **Volunteer** - Limited shift viewing only

### Permission Checks

All staff functions include permission validation:

```dart
// Check staff permissions before action
final hasPermission = await checkStaffPermission(
  userId: currentUser.uid,
  permission: 'assign_points',
);
```

## Dependencies

- `cloud_firestore` - Firestore database
- `cloud_functions` - Firebase Functions integration
- `flutter_bloc` - State management
- `auth` - Authentication integration
- `core` - Shared utilities
- `user` - User integration
- `quests` - Quest integration for point assignment

## Usage

```dart
import 'package:staff/staff.dart';

// Create new shift
final createShiftUseCase = GetIt.instance<CreateShiftUseCase>();
final result = await createShiftUseCase(
  CreateShiftParams(
    userId: 'staff_user_id',
    start: DateTime.now().add(Duration(hours: 2)),
    duration: 240,
    location: ShiftLocationsEnum.registration,
    notes: 'Morning shift',
  ),
);

// Assign points to users
final assignPointsUseCase = GetIt.instance<AssignPointsToUsersUseCase>();
final assignResult = await assignPointsUseCase(
  AssignPointsParams(
    userIds: ['user1', 'user2'],
    points: 50,
    type: PointsTypeEnum.staff,
    reason: 'Great participation',
  ),
);

// Monitor staff state
BlocBuilder<StaffBloc, StaffState>(
  builder: (context, state) {
    if (state is StaffLoaded) {
      return StaffDashboard(staffData: state.staffData);
    }
    return LoadingWidget();
  },
)
```
