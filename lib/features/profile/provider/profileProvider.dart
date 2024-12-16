import 'dart:developer';

import 'package:assignment/features/profile/model/user.dart';
import 'package:assignment/provider/provider/storageProvider.dart';
import 'package:flutter/material.dart';

class Profileprovider with ChangeNotifier {
  User mainUser = User();

  User user = User();
  UserStorageProvider userStorageProvider = UserStorageProvider();
  bool loading = false;

  Future<void> pickDate(BuildContext context, initial) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: DateTime(2015),
    );
    if (picked != null) {
      print(picked);
      user = user.copyWith(dob: picked.toString());
      notifyListeners();
    }
  }

  onPop(){
    user = mainUser;
    notifyListeners();
  }

  onEmailChanged(String value) {
    user = user.copyWith(email: value);
    notifyListeners();
  }

  onPhoneChanged(String value) {
    user = user.copyWith(phoneNumber: value);
    notifyListeners();
  }

  onPasswordChanged(String value) {
    user = user.copyWith(password: value);
    notifyListeners();
  }

  onCityChanged(String value) {
    user = user.copyWith(currentLocation: value);
    notifyListeners();
  }

  onFirstnameChanged(String value) {
    user = user.copyWith(firstName: value);
    notifyListeners();
  }

  onLastnameChanged(String value) {
    user = user.copyWith(lastName: value);
    notifyListeners();
  }

  saveProfile() async {
    try {
      loading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      await userStorageProvider.saveUser(user.email ?? user.phoneNumber!, user);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  updateProfile() async {
    try {
      loading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      await userStorageProvider.updateUser(
          user.email ?? user.phoneNumber!, user);
          mainUser = user;
      loading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
