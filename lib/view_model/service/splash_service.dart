import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class SplashService {
  Future<UserModel> getUserDate() async {
    return UserViewModel().getUser();
  }

  void checkAuthentication(BuildContext context) {
    getUserDate().then((value) async {
      debugPrint(value.token);
      if (value.token == "null" || value.token == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
