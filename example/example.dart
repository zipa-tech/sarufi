import 'package:sarufi/sarufi.dart';

void main() async {
  final bot = Sarufi(userName: "John Doe", passWord: "*****");
  //var chatbot = await bot.createBot(name: "My First Bot");
  
  print(bot.getToken());

  //print(chatbot);
  // $ Sarufi(username: John Doe, password: *****)
  // $ Bot(id: 11, name: My First Chatbot)
}

