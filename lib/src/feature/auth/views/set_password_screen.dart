import 'package:ccms/src/feature/auth/controllers/auth_controller.dart';
import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/feature/auth/views/widgets/custom_text_field.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetPasswordScreen extends ConsumerStatefulWidget {
  const SetPasswordScreen({super.key, required this.params});
  final Map<String, String> params;
  static const routePath = "/setPassword";

  @override
  ConsumerState<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends ConsumerState<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
  void _setPassword(String email) {
    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarService.showSnackBar(
          context: context, message: "Passwords do not match");
      return;
    }

    ref.read(authControllerProvider.notifier).setPassword(password: _passwordController.text,email: email, context: context);
  }

  bool confirmPasswordVisible = false;
  bool passwordVisivble = false;

  @override
  Widget build(BuildContext context) {
    final email = widget.params['email'];
    print("EMAIL = $email");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Image(
                image: AssetImage(ImageAssets.setPassword),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text("Password : ",
                  style: TextStyle(
                      fontFamily: AssetFonts.inter,
                      fontWeight: FontWeight.w600)),
            ),
            PasswordTextField(
                prefixIcon:
                    const Icon(Icons.password_sharp, color: Colors.blue),
                trailing: IconButton(
                  icon: (passwordVisivble)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility_rounded,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      passwordVisivble = !passwordVisivble;
                    });
                  },
                ),
                isObscure: !passwordVisivble,
                enable: true,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                hint: "Set Password"),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text("Confirm Password : ",
                  style: TextStyle(
                      fontFamily: AssetFonts.inter,
                      fontWeight: FontWeight.w600)),
            ),
            PasswordTextField(
                prefixIcon:
                    const Icon(Icons.password_sharp, color: Colors.blue),
                trailing: IconButton(
                  icon: (confirmPasswordVisible)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility_rounded,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                ),
                isObscure: !confirmPasswordVisible,
                enable: true,
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                hint: "Confirm Password"),
            const SizedBox(
              height: 20,
            ),
            CommonButton(
                size: MediaQuery.of(context).size,
                onTap: (){
                  _setPassword(email!);
                },
                text: "Set Password")
          ],
        ),
      ),
    );
  }
}