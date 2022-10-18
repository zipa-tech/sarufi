library sarufi;

import 'package:sarufi/exports.dart';
import 'package:http/http.dart' as http;

/// Sarufi Instance
class Sarufi {
  String userName;
  String passWord;
  String? token;

  Sarufi({required this.userName, required this.passWord, this.token});

  final log = Logger('Sarufi');
  void logger() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  Future<String> createBot({required String name}) async {
    logger();
    try {
      int id = Random().nextInt(100);
      return 'Bot(id: $id, name: $name)';
    } finally {
      log.info("Bot Created Successfully");
    }
  }

  Future headers() async {
    if (token == null) {
      var tokenInfo = await getToken();
      if (tokenInfo['token']) {
        return {
          "Authorization": "Bearer ${tokenInfo['token']}",
          "Content-Type": "application/json",
        };
      } else {
        log.warning(tokenInfo['message']);
        log.warning("Please check your credentials\nand try again");
      }
    } else {
      return {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    }
  }

  Future<dynamic> getToken() async {
    logger();
    log.info("Getting token");
    final response = await http.post(
        Uri.parse("${Statics.sarufiUrl}users/login"),
        headers: {"Accept": "application/json"},
        body: json.encode({"username": userName, "password": passWord}));
    return json.decode(response.body);
  }

  Future<bool> updateToken() async {
    final tokenInfo = await getToken();
    token = tokenInfo['token'];
    return true;
  }

  Future getSarufi(String url, [int retry = 1]) async {

    final response = await http.get(
      Uri.parse(url),
      headers: await headers(),
      );
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400 &&
      responseData['detail'] == "Token invalid") {
      log.info("Token invalid[REFRESHING]");
      updateToken();
      if (retry > 0) {
        return getSarufi(url, retry = retry - 1);
      }
    }
    return responseData;
  }

  @override
  String toString() {
    return "Sarufi(userName: $userName, passWord: $passWord)";
  }
}
