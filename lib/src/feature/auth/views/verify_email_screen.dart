import 'package:ccms/src/feature/auth/controllers/auth_controller.dart';
import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key, required this.params});
  final Map<String, String> params;
  static const routePath = "/verifyEmailScreen";

  void _verifyEmail(WidgetRef ref,String email,BuildContext context){
    ref.read(authControllerProvider.notifier).verifyEmail(email: email, context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final email = params['email'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/images/email.png"),
                  height: size.width * 0.45,
                ),
                const Text(
                  "Verify Your Account",
                  style: TextStyle(
                      fontFamily: AssetFonts.lato,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          style: TextStyle(
                              fontFamily: AssetFonts.lato,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                          text: "Check your Email "),
                      TextSpan(
                          style: const TextStyle(
                              fontFamily: AssetFonts.lato,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                          text: "$email "),
                      const TextSpan(
                          style: TextStyle(
                              fontFamily: AssetFonts.lato,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                          text:
                              "for a verification mail and then come back and click on Verify"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 55),
                Align(
                  child: CommonButton(
                      size: size,
                      onTap: () {
                        _verifyEmail(ref, email!, context);
                      },
                      text: "Verify",
                      width: size.width * 0.5),
                )
              ]),
        ),
      ),
    );
  }
}
