import 'package:assignment/extensions.dart';
import 'package:assignment/features/auth/provider/authProvider.dart';
import 'package:assignment/features/profile/provider/profileProvider.dart';
import 'package:assignment/gen/assets.gen.dart';
import 'package:assignment/main.dart';
import 'package:assignment/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool error = false;
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        return AbsorbPointer(
          absorbing: value.loading,
          child: SafeArea(
              child: Column(
            spacing: 30,
            children: [
              Assets.images.otp.image(),
              SizedBox(
                width: double.infinity,
                child: OTPTextField(
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  length: 5,
                  fieldStyle: FieldStyle.box,
                  fieldWidth: 50,
                  spaceBetween: 10,
                  hasError: error,
                  onChanged: (value) {
                    if (value == '') {
                      otp = '';
                    }
                    error = false;
                    setState(() {});
                  },
                  onCompleted: (value) {
                    otp = value;
                    setState(() {});
                  },
                ),
              ),
              FilledButton(
                  onPressed: otp.length != 5
                      ? null
                      : () {
                          if (otp != '12345') {
                            context.error("Incorrect OTP");
                          } else {
                            context.success("OTP verified");

                            if (value.email == null) {
                              value.logIN(context);
                            } else {
                              navigateKey.currentState!.pushNamedAndRemoveUntil(
                                  AppRoutes.createProfile, (route) => false);
                            }
                          }
                        },
                  child: value.loading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text("Verify"))
            ],
          )),
        );
      }),
    );
  }
}
