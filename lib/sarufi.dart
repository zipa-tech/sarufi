library sarufi;

import 'dart:math';

/// Sarufi Instance
class Sarufi {
  String userName;
  String passWord;
  Sarufi({required this.userName, required this.passWord});

  Future<String> createBot({required String name}) async {
    int id = Random().nextInt(100);
    return 'Bot(id: $id, name: $name)';
  }

  @override
  String toString() {
    return "Sarufi(userName: $userName, passWord: $passWord)";
  }
}
