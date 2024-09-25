# Comment-Me

Comment-Me is a Flutter application that allows users to view and interact with comments. It features Firebase Authentication, Firebase Remote Config, and fetches comments from an external API.

## Features

- **Firebase Authentication**: Email and password login with auth state management
- **Comments Feed**: Displays comments fetched from https://jsonplaceholder.typicode.com/comments
- **Infinite Scrolling**: Load more comments as the user scrolls
- **Pull-to-Refresh**: Allows users to refresh the comments feed
- **Email Masking**: Uses Firebase Remote Config to control email display (full or partially masked)

## Architecture: Service-Provider Architecture

The app follows a Service-Provider Architecture, which combines service-based modularity with provider-based state management. This architecture ensures clear separation of concerns and efficient state management throughout the app.

Key components:

- `models/`: Data models for the application
- `providers/`: State management using the Provider package
- `services/`: API and Firebase services
- `views/`: UI components and screens
- `app_router.dart`: Handles navigation
- `app_theme.dart`: Defines app-wide styling
- `firebase_options.dart`: Firebase configuration
- `main.dart`: Entry point of the application

Benefits of this architecture:

- Clear separation of data, business logic, and UI
- Efficient state management with Provider
- Easy to test and maintain
- Scalable for future feature additions

## Dependencies

```yaml
cloud_firestore: ^5.4.2
cupertino_icons: ^1.0.8
firebase_auth: ^5.3.0
firebase_core: ^3.5.0
firebase_database: ^11.1.3
firebase_remote_config: ^5.1.2
get: ^4.6.6
get_it: ^8.0.0
google_fonts: ^6.2.1
http: ^1.2.2
provider: ^6.1.2
```

## Setup

1. Clone the repository:

   ```
   git clone https://github.com/ramithks/comment-me.git
   ```

2. Install dependencies:

   ```
   flutter pub get
   ```

3. Configure Firebase:

   - Create a new Firebase project
   - Add your Flutter app to the Firebase project
   - Download the `google-services.json` file and place it in the `android/app` directory
   - Update `firebase_options.dart` with your Firebase configuration

4. Run the app:
   ```
   flutter run
   ```

## Firebase Integration

### Authentication

The app uses Firebase Authentication for user management. It implements auth state persistence, allowing users to remain logged in across app restarts.

### Remote Config

Firebase Remote Config is used to control email display. Set up a boolean parameter in your Firebase console:

- Parameter Name: `mask_email`
- Default Value: `false`

When `true`, emails will be partially masked (e.g., "joh\*\*\*\*@test.com").

## Key Features Implementation

### Infinite Scrolling

The comments feed implements infinite scrolling, loading more comments as the user scrolls to the bottom of the list. This ensures efficient memory usage and improves app performance.

### Pull-to-Refresh

Users can refresh the comments feed by pulling down on the list. This feature ensures that users always have access to the most up-to-date comments.

## Error Handling

The app implements comprehensive error handling for API and Firebase interactions, ensuring a smooth user experience even in case of network issues or service disruptions.

## Form Validation

User input is validated to ensure data integrity and enhance user experience.

## State Management

The app uses the Provider package for state management, allowing for efficient and scalable state updates across the application.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
