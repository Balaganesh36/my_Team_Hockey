# Fix and Run Hockey Team App

Consolidate the codebase, fix missing data/assets, and clean up redundant files to ensure the app runs correctly with a modern theme and full player list.

## User Review Required

> [!IMPORTANT]
> I will be consolidating the logic from `main1.dart` (data) and `main2.dart` (modern theme) into the primary `main.dart`. `main1.dart` and `main2.dart` will be removed to avoid confusion.
>
> I will also be renaming `upcoming_events_page.dart..dart` to `upcoming_events_page.dart` and fixing the broken asset references in `login_page.dart`.

## Proposed Changes

### Core UI and Data Consolidation

#### [MODIFY] [main.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/main.dart)
- Update with the modern navy/blue theme from `main2.dart`.
- Restore the full player list from `main1.dart`.
- Fix the `background` and `withOpacity` deprecation warnings.
- Correct all imports.

#### [DELETE] [main1.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/main1.dart)
#### [DELETE] [main2.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/main2.dart)

### Feature Pages Cleanup

#### [NEW] [upcoming_events_page.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/upcoming_events_page.dart)
- Replace the commented-out/empty versions with the actual implementation from the `..dart` file.
- Fix spelling of "TOURNAMENT".

#### [DELETE] [upcoming_events_page.dart.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/upcoming_events_page.dart.dart)
#### [DELETE] [upcoming_events_page.dart..dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/upcoming_events_page.dart..dart)

#### [MODIFY] [login_page.dart](file:///C:/Users/user/AndroidStudioProjects/my_app_6/lib/login_page.dart)
- Fix missing asset `login_bg.jpg` by using an existing hockey-themed asset.
- Replace missing `google.png` with a generic `G` icon or a placeholder.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no errors or warnings remain.
- Run `flutter run` (if a device is available) or perform a build check.

### Manual Verification
- Verify the Home screen shows the live score pulse (from `main2.dart`).
- Verify the Players list is populated with data.
- Verify the Upcoming Events page is accessible and displays correctly.
- Verify the Login page opens without asset errors.
