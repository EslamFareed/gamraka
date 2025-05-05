import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> login({
    required String phone,
    required String name,
    required String idNumber,
    required String id,
    required String image,
  }) async {
    await sharedPreferences.setBool("isLogin", true);
    await sharedPreferences.setString("phone", phone);
    await sharedPreferences.setString("name", name);
    await sharedPreferences.setString("idNumber", idNumber);
    await sharedPreferences.setString("image", image);
    await sharedPreferences.setString("id", id);
  }

  static bool isLogin() => sharedPreferences.getBool("isLogin") ?? false;

  static String getName() => sharedPreferences.getString("name") ?? "";
  static String getPhone() => sharedPreferences.getString("phone") ?? "";
  static String getIdNumber() => sharedPreferences.getString("idNumber") ?? "";
  static String getId() => sharedPreferences.getString("id") ?? "";
  static String getImage() => sharedPreferences.getString("image") ?? "";
}
