# Recipe Finder APP

AI-Powered Recipe Finder app

## How to run the app

In order to run the app you must have flutter set up. You can 
find the set up steps [here](https://docs.flutter.dev/get-started/install)

This app uses Gemini API for generating content so an API key is need
in order to run the app. You can create an api key [here](https://aistudio.google.com/app/apikey).

You can run the app using Android Studio (recommended) or your preferred IDE.
You can also run the app by executing following commands:

```
flutter devices - lists all connected devices (copy the id of the device you want to use)
```

```
flutter run -d <device id> --dart-define=geminiApiKey=<Your Gemini API Key>
```

You can also store your gemini api key in a json file (api_keys.json) in the root of the project.

```
api_keys.json
{
    "geminiApiKey": "<Your Gemini API Key>"
}
```
```
flutter run -d <device id> --dart-define-from-file=api_keys.json
```


## Architecture

This application uses [Bloc Architecture](https://bloclibrary.dev/architecture/) this makes the app
modular as new Data Sources can be easily integrated

## Features

- Generate suggestions for recipes based on user input
- Save recipes as favorites
- User search history
- Persistent favorite recipes
- App Icon
- Loading Shimmer animation
- Error handling
- UI states (loading, error, success)
- Some Unit tests
- [App localization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
