import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/user_data_model.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    myRepo.loginApi(data).then((value) {
      setLoading(false);
      var dataa = Provider.of<UserViewModel>(context, listen: false);
      dataa.saveUser(
        UserModel(
          token: value['token'].toString(),
        ),
      );
      Utils.flushBarErrorMessage('LOGIN SUCCESSFULLY', context);
      Navigator.pushNamed(context, RoutesName.home);
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      debugPrint(error.toString());
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('Sign Up SUCCESSFULLY', context);
      Navigator.pushNamed(context, RoutesName.home);
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      debugPrint(error.toString());
    });
  }

  ApiResponse<UserDataModel> userData = ApiResponse.loading();

  setUserList(ApiResponse<UserDataModel> response) {
    userData = response;
    notifyListeners();
  }

  Future<void> getUserDataApi(dynamic data, BuildContext context) async {
    setUserList(ApiResponse.loading());

    myRepo.getUserDataApi().then((value) {
      setUserList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
    });
  }
}
