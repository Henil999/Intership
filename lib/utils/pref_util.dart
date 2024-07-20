import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  SharedPreferences? _sharedPreferences;

  PrefUtil() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  void setUserLoggedIn(String username) =>
      _sharedPreferences?.setString("userLoggedIn", username);

  String? getUserLoggedIn() => _sharedPreferences?.getString("userLoggedIn");
}
