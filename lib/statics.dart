import 'package:logging/logging.dart';

class Statics {
  static String sarufiUrl = "https://api.sarufi.io/";

  final log = Logger('Sarufi');
  void logger() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
