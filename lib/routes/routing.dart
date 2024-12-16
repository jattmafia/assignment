import 'package:assignment/features/auth/screen/loginScreen.dart';
import 'package:assignment/features/auth/screen/otpScreen.dart';
import 'package:assignment/features/profile/screen/profileView.dart';
import 'package:flutter/material.dart';
import 'package:assignment/features/profile/screen/createProfile.dart';

class AppRoutes{
  static const String login = '/login';
  static const String otp = '/otp';
  static const String createProfile = '/createProfile';
  static const String profileView = '/profileView';



  static Map<String, WidgetBuilder> routes = {
    login : (context) => Loginscreen(),
    otp : (context) => OtpScreen(),
    createProfile : (context) {
       if(ModalRoute.of(context)?.settings.arguments == true){
        return CreateProfileScreen(edit: true,);
      }else{
         return CreateProfileScreen();
      }
    },
    profileView : (context){
      if(ModalRoute.of(context)?.settings.arguments == true){
        return Profileview(confirmation: true);
      }else{
         return Profileview();
      }
     
    },
  };
}