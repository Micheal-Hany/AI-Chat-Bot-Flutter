# AI Chatbot App

This is a Flutter application that provides a conversational interface with an AI chatbot named Gemini. Users can interact with Gemini in real-time, view past messages, and send new messages.

## Screenshot

[Untitled design](https://github.com/user-attachments/assets/8e3e3d4c-0178-47f1-8545-2bc38ebf0cf9)


## Features

- **Chat Interface**: Engage in interactive two-way communication with the AI chatbot.
- **Chat History**: Access and review previous conversations with Gemini.
- **Seamless Scrolling**: The chat screen automatically scrolls down to display the latest message, ensuring a smooth conversation flow.
- **Local Data Storage**: The app utilizes Hive for storing chat messages or other app data locally on the device (depending on `hive` and `hive_flutter` dependencies).

## Dependencies

- `flutter`: The core framework for building cross-platform mobile apps.
- `cupertino_icons` (optional): Provides Cupertino icons for a more native-looking iOS style.
- `flutter_dotenv` (optional): Enables loading environment variables from a `.env` file.
- `flutter_markdown` : Allows displaying markdown content within your app.
- `flutter_spinkit` (optional): Provides various loading spinners for visual feedback.
- `google_generative_ai`: Integrates with Google's generative AI services for chatbot functionality.
- `hive`: A NoSQL database for storing app data locally.
- `hive_flutter`: Provides Flutter-specific bindings for using Hive.
- `image_picker`: Enables picking images from the device's gallery or camera.
- `path_provider`: Helps determine platform-specific file system paths for storing data.
- `provider`: A state management solution for managing app data across widgets.
- `uuid`: Generates Universally Unique Identifiers (UUIDs) for various purposes.

## Installation

To install the application, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Micheal-Hany/AI-Chat-Bot-Flutter.git
   ```
2. Navigate to the project directory:
   ```bash
   cd AI-Chat-Bot-Flutter
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```

## Development Setup

1. **Prerequisites**: Ensure you have Flutter and Dart installed on your development machine. You can follow the official installation guide at [Flutter Get Started](https://docs.flutter.dev/get-started/install).
2. **Clone or Download the Project**: Obtain the project code, either by cloning the Git repository or downloading the source files.
3. **Get Your Gemini API** [Go to google AI for Developers](https://ai.google.dev/) and get your Api Key
4. **Run the App**: Navigate to the project directory in your terminal and execute `flutter run`.

## Usage

To run the application, use the following command:
```bash
flutter run
```

The home screen serves as the central navigation point for this AI chatbot app. Users can:

- View their chat history.
- Engage in real-time chat with the chatbot.
- Access their profile information and settings.

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature:
   ```bash
   git checkout -b feature/YourFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/YourFeature
   ```
5. Create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Aayush D.C Dangi (dcaayushd)
