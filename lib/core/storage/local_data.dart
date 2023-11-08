import 'package:hive_flutter/adapters.dart';

class AppLocal {
  static String Image_Key = 'Image_Key';
  static String Name_Key = 'Name_Key';
  static String IS_UPLOAD = 'IS_UPLOAD';

  static cacheData(String key, dynamic value) async {
    var box = Hive.box('user');
    await box.put(key, value);
  }

  static Future<dynamic> getData(
    String key,
  ) async {
    var box = Hive.box('user');
    return await box.get(key);
  }

  static deleteData(
    String key,
  ) async {
    var box = Hive.box('user');
    await box.delete(key);
  }
}
