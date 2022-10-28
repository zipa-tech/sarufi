library sarufi;

import 'package:sarufi/exports.dart';
import 'package:http/http.dart' as http;

/// Sarufi Instance
class Sarufi {
  String userName;
  String passWord;
  String? token;
  dynamic data;
  String chatId = const Uuid().v4();

  Sarufi(
      {required this.userName, required this.passWord, this.token, this.data});

  final log = Logger('Sarufi');
  void logger() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }



  // 134 - 163
  Future getRequest(
      {required String url,
      required dynamic headers,
      int retry = 1}) async {

    final response = await http.get(Uri.parse(url), headers: headers);
    var jsonRespose = json.decode(response.body);
    
    if (response.statusCode == 200) {
      return jsonRespose;
    } else if (response.statusCode == 400 &&
        (jsonRespose['detail'] == "Token invalid" ||
            jsonRespose['detail'] == "Token invalid")) {
      
      log.info("Token invalid[REFRESHING]");
      await updateToken();

      if (retry > 0) {
        await getRequest(url:url, headers:headers, retry:retry - 1);
      }
      log.warning("Error [GET]");
    }
    return json.decode(response.body);
  }

  // 164 - 204
  Future postRequest(
      {required String url,
      required dynamic data,
      required dynamic headers,
      int retry = 1}) async {

    final response = await http.post(Uri.parse(url), headers: headers, body: data);
    var jsonRespose = json.decode(response.body);
    
    if (response.statusCode == 200) {
      return jsonRespose;
    } else if (response.statusCode == 400 &&
        (jsonRespose['detail'] == "Token invalid" ||
            jsonRespose['detail'] == "Token invalid")) {
      
      log.info("Token invalid[REFRESHING]");
      await updateToken();

      if (retry > 0) {
        await postRequest(url:url, headers:headers, data:data, retry:retry - 1);
      }
      log.warning("Error [POST]");
    }
    return json.decode(response.body);
  }

  // 205 - 240
  Future putRequest(
      {required String url,
      required dynamic headers,
       required dynamic data,
      int retry = 1}) async {

    final response = await http.put(Uri.parse(url), headers: headers, body: data);
    var jsonRespose = json.decode(response.body);
    
    if (response.statusCode == 200) {
      return jsonRespose;
    } else if (response.statusCode == 400 &&
        (jsonRespose['detail'] == "Token invalid" ||
            jsonRespose['detail'] == "Token invalid")) {
      
      log.info("Token invalid[REFRESHING]");
      await updateToken();

      if (retry > 0) {
        await getRequest(url:url, headers:headers, retry:retry - 1);
      }
      log.warning("Error [PUT]");
    }
    return json.decode(response.body);
  }

    // 242 - 275
  Future deleteRequest(String url, [int retry = 1]) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: await headers(),
    );

    var jsonRespose = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonRespose;
    } else if (response.statusCode == 400 &&
        (jsonRespose['detail'] == "Token invalid" ||
            jsonRespose['detail'] == "Token invalid")) {
      log.info("Token invalid[REFRESHING]");
      await updateToken();

      if (retry > 0) {
        await deleteRequest(url, retry = retry - 1);
      }

      log.warning("Error [DELETE]");
    }
    return json.decode(response.body);
  }

// 276 - 323
Future<String> createBot({
  required String name,
  required String description,
  required String industry,
  required Map flow,
  required List intents,
  required bool visible,
}) async {
  log.info("Creating bot");
  String botCreateUrl = "${Statics.sarufiUrl}chatbot";

    data = {
      "name": name,
      "description": description,
      "intents": intents,
      "flows": flow,
      "industry": industry,
      "visible_on_community": visible,
    };

    final response = await postRequest(url:botCreateUrl, headers:headers(), data:data);
    if (response.statusCode == 200) {
      //return Bot(response.json(), token=self.token)
    }
    return response;
  }

  // 324 - 367
  Future createFromFile({
    required String intents,
    required String flow,
    required String  metadata
    }){
    final intents = readFile(intents);
    final flow = readFile(flow)
    final metadata = readFile(metadata) ?? {};

    return createBot(name:metadata.get("name", "put name here"),
                    description:metadata.get("description"),
                    industry:metadata.get("industry"),
                    visible:metadata.get("visible_on_community"),
                    intents:intents,
                    flow:flow,
                  );
  }

  // 369 - 421
Future updateBot({
  required int id,
  required String name,
  required String description,
  required String industry,
  required Map flow,
  required List intents,
  required bool visible,
}) async {
  log.info("Updating bot");
  String botCreateUrl = "${Statics.sarufiUrl}chatbot/$id";

    data = {
      "name": name,
      "description": description,
      "intents": intents,
      "flows": flow,
      "industry": industry,
      "visible_on_community": visible,
    };

    final response = await putRequest(url:botCreateUrl, headers:headers(), data:data);
    if (response.statusCode == 200) {
      //return Bot(response.json(), token=self.token)
    }
    return response;
  }

    // 422 - 471
  Future updateFromFile({
    required int id,
    required String intents,
    required String flow,
    required String  metadata
    }){
    final intents = readFile(intents);
    final flow = readFile(flow)
    final metadata = readFile(metadata) ?? {};
    
    return updateBot(
        id:id,
        name:metadata.get("name", "put name here"),
        description:metadata.get("description"),
        industry:metadata.get("industry"),
        visible:metadata.get("visible_on_community"),
        intents:intents,
        flow:flow,
      );
  }

  // 472 - 498
  Future getBot({required int id}) async {
    log.info("Getting bot with id: $id");
    String botUrl = "${Statics.sarufiUrl}/chatbot$id";
    final response = await  getRequest(url: botUrl, headers: headers());
    if (response.statusCode == 200){
      // return Bot(response.json(), token=self.token);
    }
    
  return json.decode(response.body);
  }

  // 
  Future bots() async {
    log.info("Getting bots");
      //List sarufiBots = [];
    String botUrl = "${Statics.sarufiUrl}/chatbots";
    final response = await  getRequest(url: botUrl, headers: headers());
    if (response.statusCode == 200){
      for (var bot in json.decode(response.body)){
        //sarufiBots.add(Bot(bot,token:token));
      }
    }
   return json.decode(response.body);
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
      await updateToken();
      if (retry > 0) {
        return getSarufi(url, retry = retry - 1);
      }
    }
    return responseData;
  }



  void deleteBot(String id) async {
    String deleteUrl = "${Statics.sarufiUrl}chatbot/$id";
    await deleteRequest(deleteUrl);
  }

  // 832 - 836
  @override
  String toString() {
    return "Sarufi(userName: $userName, passWord: $passWord)";
  }

  // Bot Funcs
  dynamic id() {
    return data['id'];
  }

  name() {
    return data['name'];
  }

  updateBot(
      [id, name, description, intents, industry, flow, bool? visible]) async {
    log.info("Updating bot");
    data = {
      "name": name,
      "description": description,
      "intents": intents,
      "flows": flow,
      "industry": industry,
      "visible_on_community": visible,
    };

    var response = await http.put(Uri.parse("${Statics.sarufiUrl}chatbot/$id"),
        body: data);
    if (response.statusCode == 200) {
      return {'data': json.decode(response.body), 'token': token};
    }
    return json.decode(response.body);
  }

  sarufiBot(dynamic botData, String token, {required data}) {
    return data;
  }

  industry() {
    return data['industry'];
  }
}
