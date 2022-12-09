import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/network/baseApiService.dart';
import 'package:mvvm/data/network/networkApiService.dart';
import 'package:mvvm/model/user_data_model.dart';
import 'package:mvvm/res/app_urls.dart';
import 'package:provider/provider.dart';

import '../view_model/user_view_model.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          _apiServices.getPostApiResponse(AppUrls.loginUrl, data);
      // var dataa = Provider.of<UserViewModel>(context,listen: false);
      // dataa.saveUser(response);

      return response;
    } catch (e) {
      debugPrint('LOGIN ERROR : ${e.toString()}');
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          _apiServices.getPostApiResponse(AppUrls.ragisterUrl, data);
      return response;
    } catch (e) {
      debugPrint('RAGISTER ERROR : ${e.toString()}');
    }
  }

  Future<UserDataModel> getUserDataApi() async {
    try {
      dynamic response = _apiServices.getGetApiResponse(AppUrls.userDataUrl);
      return response = UserDataModel.fromJson(response);
    } catch (e) {
      debugPrint('USER_DATA ERROR : ${e.toString()}');
      throw e;
    }
  }
}
