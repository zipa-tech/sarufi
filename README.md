SARUFI: This is a Dart SDK that helps users intercat with sarufi.io in the Dart projects.

## Features

SARUFI: No available features.

## Getting started

SARUFI: In your [pubspec.yaml]() file of your project add

```dart
dependencies:
    sarufi:
```

## Usage

SARUFI: No examples currently.


```dart
// main.dart
import 'package:sarufi/sarufi.dart';


void main() async {
    String userName = "Your Sarufi Username";
    String passWord = "Your Sarufi Password";

    final bot = Sarufi(username:userName, password:passWord);
    var chatbot = await bot.createBot(name:"My First Bot");
    
    print(chatbot);
    // Bot(id:11, name:My First Chatbot)
}
```

## Additional information

SARUFI: For issues about the project write to us at [*Github*](https://github.com/kalokola/sarufi)

Inspired

1. [*Sarufi*](https://docs.saufi.io)