import 'dart:developer';

import 'package:assignment/extensions.dart';
import 'package:assignment/features/profile/provider/profileProvider.dart';
import 'package:assignment/main.dart';
import 'package:assignment/routes/routing.dart';
import 'package:assignment/widgets/cityDropdown.dart';
import 'package:assignment/widgets/textfieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  final bool edit;
  const CreateProfileScreen({super.key, this.edit = false});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        if (!widget.edit) {
          return Future.value(false);
        } else {
          if(navigateKey.currentState!.canPop()){
            context.read<Profileprovider>().onPop();
            navigateKey.currentState!.pop();
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,
          onPressed: () {
             if(navigateKey.currentState!.canPop()){
            context.read<Profileprovider>().onPop();
            navigateKey.currentState!.pop();
          }
          },
          ),
          title: Text(
            widget.edit ? "Edit Profile" : "Create Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
          key: formKey,
          child: Padding(
            padding: context.kdefaultPadding,
            child: Consumer<Profileprovider>(
              builder: (BuildContext context, profilevalue, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First name"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      hintText: "Enter your first name",
                      initialValue: profilevalue.user.firstName,
                      onChanged: (value) {
                        profilevalue.onFirstnameChanged(value);
                      },
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please enter your first name";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Last name"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      initialValue: profilevalue.user.lastName,
                      onChanged: (value) {
                        profilevalue.onLastnameChanged(value);
                      },
                      hintText: "Enter your last name",
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please enter your last name";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Dob"),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await profilevalue.pickDate(
                            context,
                            profilevalue.user.dob != null
                                ? DateTime.parse(profilevalue.user.dob!)
                                : DateTime(2015));
      
                        setState(() {});
                      },
                      child: CustomTextfield(
                        initialValue: profilevalue.user.dob?.toFormattedDate(),
                        enable: false,
                        hintText: "Select your date of birth",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Please select your date of birth";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("City"),
                    const SizedBox(
                      height: 10,
                    ),
                    CityDropdownWidget(
                      selectedCity: profilevalue.user.currentLocation,
                      onCityChanged: (value) {
                        profilevalue.onCityChanged(value!);
                      },
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please select your city";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (widget.edit) {
                                try {
                                  await profilevalue.updateProfile();
                                  navigateKey.currentState!
                                      .pushNamedAndRemoveUntil(
                                          AppRoutes.profileView,
                                          (route) => false);
                                } catch (e) {
                                  log(e.toString());
                                }
                              } else {
                                navigateKey.currentState!.pushNamed(
                                    AppRoutes.profileView,
                                    arguments: true);
                              }
                            }
                          },
                          child: Text(
                              widget.edit ? "Update Profile" : "Create Profile")),
                    )
                  ],
                );
              },
            ),
          ),
        ))),
      ),
    );
  }
}
