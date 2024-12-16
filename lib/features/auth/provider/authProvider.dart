import 'dart:developer';

import 'package:assignment/features/profile/model/user.dart';
import 'package:assignment/features/profile/provider/profileProvider.dart';
import 'package:assignment/main.dart';
import 'package:assignment/provider/provider/storageProvider.dart';
import 'package:assignment/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  String? email;
  String? password;
  String? phone;
  bool loading = false;
  UserStorageProvider userStorageProvider = UserStorageProvider();

  void reset() {
    email = null;
    password = null;
    phone = null;
    notifyListeners();
  }

  logIN(context) async {
    try {
      final profileProvider =
          Provider.of<Profileprovider>(context, listen: false);

      loading = true;
      notifyListeners();

      await Future.delayed(Duration(seconds: 2));
      if (email != null) {
        bool emailExist = await userStorageProvider.doesEmailExist(email!);
        if (emailExist) {
          User? a = await userStorageProvider.getUser(email!);
          if (a!.password != password) {
            throw "Invalid password";
          } else {
            profileProvider.mainUser = a;
            profileProvider.user = a;
            loading = false;
            notifyListeners();
            navigateKey.currentState!
                .pushReplacementNamed(AppRoutes.profileView);
          }
        } else {
          loading = false;
          notifyListeners();

          profileProvider.onEmailChanged(email!);
          profileProvider.onPasswordChanged(password!);

          navigateKey.currentState!.pushNamed(AppRoutes.otp);
          return;
        }
      } else {
        bool phoneExist = await userStorageProvider.doesphoneExist(phone!);
        
        if (phoneExist) {
          User? a = await userStorageProvider.getUser(phone!);
          print(a);
          profileProvider.mainUser = a!;
          profileProvider.user = a;
          loading = false;
          notifyListeners();
          navigateKey.currentState!.pushNamedAndRemoveUntil(AppRoutes.profileView, (route) => false);
        } else {
          loading = false;
          notifyListeners();

          profileProvider.onPhoneChanged(phone!);

          navigateKey.currentState!.pushNamedAndRemoveUntil(AppRoutes.createProfile, (route) => false);
          return;
        }
      }
    } catch (e) {
      log(e.toString());
      loading = false;
      notifyListeners();
      rethrow;
    }
  }
}
