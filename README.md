<samp>

# [Sarufi](https://pub.dev/packages/sarufi/)

[![Made in Tanzania](https://img.shields.io/badge/made%20in-tanzania-008751.svg?style=flat-square)](https://github.com/Tanzania-Developers-Community/made-in-tanzania)

This is a Dart SDK that helps users interact with [sarufi.io](https://docs.sarufi.io) in their Dart projects. 


## Use Case

1. Integrating Conversational AI Chatbots in [**Flutter**](https://github.com/flutter/flutter) Apps and Dart [**Jaguar**](https://github.com/Jaguar-dart/jaguar) Web applications

## Getting started
**Steps to install Sarufi to your Project**

1. In your Project's [**pubspec.yaml**]() file of your project add the


```yaml
dependencies:
    sarufi:
```
2. After run, to install the package in your project

```bash
    $ flutter pub get
```
You can skip **Step 1** and **Step 2** and simplly run 

```bash
    $ flutter pub add sarufi
```
This will add sarufi in the [pubspec yaml]() with the caret *sarufi:^0.0.1* of the latest version.

## Usage
Below is how you can easily create and view properties of your Chat Bots in dart.

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

For issues about the project write to us at [*Github*](https://github.com/kalokola/sarufi)

Inspiration

1. [*Sarufi*](https://docs.saufi.io/)
2. [*Neuro Tech Africa*](https://neurotech.africa/)