// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/environment.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/utils/logger.dart';
import 'package:fashon_shop/common/widgets/error_modal.dart';
import 'package:fashon_shop/src/auth/models/auth_token_model.dart';
import 'package:fashon_shop/src/auth/models/profile_model.dart';
import 'package:fashon_shop/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void loginFunction(String data, BuildContext context) async {
    setLoading();

    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/token/login/');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        final controller = Provider.of<TabIndexNotifier>(context, listen: false);
        String accessToken = accessTokenFromJson(response.body).authToken;

        Storage().setString('accessToken', accessToken);

        getUser(accessToken, context);

        setLoading();
        controller.setIndex = 0;
        context.go('/home');
      }

      if (response.statusCode == 400) {
        setLoading();
        showErrorPopup(context, 'Username or Password Incorrect!', null, null);
      }
    } catch (e) {
      setLoading();
      TLoggerHelper.debug(e.toString());
      showErrorPopup(context, e.toString(), null, null);
    }
  }

  void registrationFunction(String data, BuildContext context) async {
    setLoading();

    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        setLoading();
        context.pop();
      } else if (response.statusCode == 400) {
        setLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(
          context,
          data['password'][0],
          null,
          null,
        );
      }
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext context) async {
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/me/');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        Storage().setString(accessToken, response.body);
      }
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
  }
}
