# MovieExplorer

A Flutter project to explore popular movies using the TMDB API.

## Description

MovieExplorer is a Flutter application that allows users to explore popular movies. The application includes the following features:

- List of popular movies.
- Movie details including synopsis, rating, and more.
- Multi-language support (English and Spanish).
- Infinite scrolling to load more movies as the user scrolls down.

## Configuration

To configure the project, follow these steps:

1. Clone the repository to your local machine.
2. Ensure you have Flutter installed on your system.
3. Run `flutter pub get` to install the project dependencies.

### Setting up the Bearer Token

To access the TMDB API, you need to add your Bearer Token in the `env.json` file. Follow these steps:

1. Open the `env.json` file located at the root of the project.
2. Replace the placeholder with your Bearer Token received via email. The file should look like this:

```json
{
    "BEARER_TOKEN": "your_bearer_token_here"
}
```

### Running the Application
To run the application in development mode, use the following command:

```shell
flutter run --dart-define-from-file env.json
```

### Launch Configuration
If you are using Visual Studio Code, you can use the provided launch.json configuration to run the application. Here is an example configuration:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "movies_app",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define-from-file",
                "env.json",
            ]
        }
    ]
}
```

#### Contributing
Contributions are welcome. Please open an issue or a pull request to discuss any changes you would like to make.

#### License
This project is licensed under the MIT License. See the LICENSE file for more details.