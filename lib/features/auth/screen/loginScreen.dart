import 'package:assignment/extensions.dart';
import 'package:assignment/features/auth/provider/authProvider.dart';
import 'package:assignment/gen/assets.gen.dart';
import 'package:assignment/main.dart';
import 'package:assignment/routes/routing.dart';
import 'package:assignment/widgets/textfieldWidget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Loginscreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final obsecure = useState(true);

    final controller = useAnimationController(
      duration: const Duration(seconds: 5),
    );

    final mobileLogin = useState(true);

    useEffect(() {
      controller.repeat(reverse: true);
      return () {
        if (controller.status != AnimationStatus.dismissed) {
          controller.stop();
        }
        if (!controller.status.isAnimating) {
          controller.dispose();
        }
      };
    }, []);

    final animation = useMemoized(() => Tween<Offset>(
          begin: const Offset(-0, 0),
          end: const Offset(1.3, 0),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.linear,
        )));

    return Scaffold(body: SingleChildScrollView(
      child: Consumer<AuthProvider>(
        builder: (context, provider, Widget? child) {
          return AbsorbPointer(
            absorbing: provider.loading,
            child: Form(
              key: formKey.value,
              child: SafeArea(
                  child: Padding(
                padding: context.kdefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                        position: animation,
                        child: SvgPicture.asset(Assets.images.login)),
                    Text(
                      "Login",
                      style: context.style.headlineLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    mobileLogin.value
                        ? CustomTextfield(
                            hintText: 'Enter your mobile number',
                            onChanged: (value) {
                              provider.phone = value;
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Mobile number is required";
                              } else if (p0.length != 10) {
                                return "Mobile number must be 10 digits";
                              }
                              return null;
                            },
                          )
                        : CustomTextfield(
                            hintText: 'Enter your email',
                            onChanged: (value) {
                              provider.email = value;
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Email is required";
                              } else if (EmailValidator.validate(p0) == false) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!mobileLogin.value)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomTextfield(
                          obscureText: obsecure.value,
                          hintText: 'Enter your password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              obsecure.value = !obsecure.value;
                            },
                            child: Icon(obsecure.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          onChanged: (value) {
                            provider.password = value;
                          },
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                            onPressed: () async {
                              if (formKey.value.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                if (mobileLogin.value) {
                                  navigateKey.currentState!
                                      .pushNamed(AppRoutes.otp);
                                  return;
                                } else {
                                  try {
                                    await provider.logIN(context);
                                  } catch (e) {
                                    if (context.mounted) {
                                      context.error(e.toString());
                                    }
                                  }
                                }
                              }
                            },
                            child: provider.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Sign In"))),
                    Center(
                        child: TextButton(
                            onPressed: () {
                              provider.reset();
                              formKey.value.currentState!.reset();

                              mobileLogin.value = !mobileLogin.value;
                            },
                            child: Text(mobileLogin.value
                                ? "Login with email"
                                : "Login with mobile")))
                  ],
                ),
              )),
            ),
          );
        },
      ),
    ));
  }
}
