import 'package:flutter_test/flutter_test.dart';

import 'package:sarufi/sarufi.dart';

void main() async {
  test('creates a initial bot', () async {
    final bot = Sarufi(userName: "brightius", passWord: "***");
    expect(await bot.createBot(name: 'My First Bot'), 'Bot(id: 11, name: My First Bot)');
  });
}
