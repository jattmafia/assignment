import 'dart:developer';

import 'package:assignment/extensions.dart';
import 'package:assignment/features/profile/provider/profileProvider.dart';
import 'package:assignment/main.dart';
import 'package:assignment/routes/routing.dart';
import 'package:assignment/widgets/profiletextWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profileview extends StatelessWidget {
  final bool confirmation;
  const Profileview({super.key, this.confirmation = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:navigateKey.currentState!.canPop() ? BackButton(
          color: Colors.white,
        ) : null,
        title: Text(
          confirmation ? "Confirm Profile" : "Profile",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Consumer<Profileprovider>(
            builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!confirmation)
                  Align(
                      alignment: Alignment.topRight,
                      child: FilledButton(
                          onPressed: () {
                            navigateKey.currentState!.pushNamed(
                                AppRoutes.createProfile,
                                arguments: true);
                          },
                          child: Text("Edit Profile"))),
                const SizedBox(
                  height: 20,
                ),
                ProfileField(
                  label: "First Name",
                  value: value.user.firstName.toString(),
                ),
                ProfileField(
                  label: "Last Name",
                  value: value.user.lastName.toString(),
                ),
                ProfileField(
                  label: "DOB",
                  value: value.user.dob.toString().toFormattedDate(),
                ),
                ProfileField(
                  label: "City",
                  value: value.user.currentLocation.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (confirmation)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () async {
                          try {
                            await value.saveProfile();
                            if (context.mounted) {
                              context.success("Profile saved successfully");
                            }

                            navigateKey.currentState!.pushNamedAndRemoveUntil(
                                AppRoutes.login, (route) => false);
                          } catch (e) {
                            log(e.toString());
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
                            : Text("Save")),
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}
