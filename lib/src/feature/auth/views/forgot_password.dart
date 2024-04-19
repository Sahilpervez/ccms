import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:go_router/go_router.dart';

// import 'verification.dart';
import 'widgets/authFormField.dart';
import 'widgets/auth_form_builder.dart';
import 'widgets/auth_form_button.dart';

final emailProvider = StateProvider<String>((ref) => "");

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const routePath = "/ForgotPassword";
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  void _handleNavigation(WidgetRef ref) {
    print("Hii ${_emailController.text}");
    ref.read(emailProvider.notifier).update((state) => _emailController.text);
    // context.push(VerificationScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (kDebugMode) {
      print("${size.height} , ${size.width}");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kcAuthThemeColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return AuthFormBuilder(
            backButtonFunction: (){
              context.pop();
            },
            size: size,
            authForm: Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                children: [
                  AuthFormField(
                    ctx: context,
                    controller: _emailController,
                    title: "EMAIL",
                    hintText: "example@gmail.com",
                    bottomSpacing: 10,
                    isPassword: false,
                  ),
                  Consumer(builder: (context, ref, child) {
                    return AuthFormButton(
                        constraints: constraints,
                        text: "SEND CODE",
                        onPressed: () {
                          _handleNavigation(ref);
                        });
                  }),
                ],
              ),
            ),
            formTitle: "Forgot Password",
            formSubtitle: "Please sign in to your existing account",
            backButton: true,
          );        
        }),
      ),
    );
  }
}
