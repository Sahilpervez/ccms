import 'package:flutter/material.dart';
import 'package:ccms/src/feature/auth/views/login.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:go_router/go_router.dart';

// import 'connect_your_accounts.dart';
import 'widgets/authFormField.dart';
import 'widgets/auth_form_builder.dart';
import 'widgets/auth_form_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const routePath = "/SignUp";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcAuthThemeColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return AuthFormBuilder(
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
                      controller: _nameController,
                      title: "NAME",
                      hintText: "John Doe",
                      bottomSpacing: 15),
                  AuthFormField(
                      ctx: context,
                      controller: _emailController,
                      title: "EMAIL",
                      hintText: "example@gmail.com",
                      bottomSpacing: 15),
                  AuthFormField(
                    ctx: context,
                    controller: _passwordController,
                    title: "PASSWORD",
                    isPassword: true,
                    bottomSpacing: 15,
                    hintText: "**********",
                  ),
                  AuthFormField(
                    ctx: context,
                    controller: _confirmPasswordController,
                    title: "CONFIRM PASSWORD",
                    hintText: "********",
                    bottomSpacing: 10,
                    isPassword: true,
                  ),
                  AuthFormButton(
                      constraints: constraints,
                      text: "SIGN UP",
                      onPressed: () {
                        // context.push(ConnectYourAccounts.routePath);
                      }),
                ],
              ),
            ),
            formTitle: "Sign Up",
            formSubtitle: "Please sign up to get started",
            backButton: true,
            backButtonFunction: () {
              // Navigator.of(context).pop();
              context.go(LoginScreen.routePath);
            },
          );
        }),
      ),
    );
  }
}