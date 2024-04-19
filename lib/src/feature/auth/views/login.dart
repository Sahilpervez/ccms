import 'package:ccms/src/feature/auth/controllers/auth_controller.dart';
import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/feature/auth/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key, required this.params}) : super(key: key);
  final Map<String,String> params ;
  static const routePath = "/Login";
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // final _form = GlobalKey();
  // bool _rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitDetails(){
    ref.read(authControllerProvider.notifier).login(context: context, email: _emailController.text, password: _passwordController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.params['email']!;
  }

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      // backgroundColor: AppColors.kcAuthThemeColor,
      backgroundColor: Colors.white,
      body: SafeArea(
        // child: LayoutBuilder(builder: (ctx, constraints) {
        //   return AuthFormBuilder(
        //     formTitle: "Login",
        //     formSubtitle: "Please sign in with your existing account",
        //     size:size,
        //     authForm: Form(
        //       key: _form,
        //       child: ListView(
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: 24, vertical: 24),
        //         children: [
        //           AuthFormField(
        //               controller: _emailController,
        //               title: "EMAIL",
        //               hintText: "example@gmail.com",
        //               ctx: context),
        //           AuthFormField(
        //               ctx: context,
        //               controller: _passwordController,
        //               title: "PASSWORD",
        //               hintText: "**********",
        //               isPassword: true),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               RememberMeBox (
        //                 toogleRem: () {
        //                   setState(() {
        //                     _rememberMe = !_rememberMe;
        //                   });
        //                 },
        //                 rememberMe: _rememberMe,
        //                 constraints: constraints,
        //               ),
        //               InkWell(
        //                 onTap: () {
        //                   // context.push(ForgotPasswordScreen.routePath);
        //                   // context.go(ForgotPasswordScreen.routePath);
        //                 },
        //                 child: SizedBox(
        //                   width: min(115, constraints.maxWidth * 0.359),
        //                   child: const Text(
        //                     'Forgot Password',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 14,
        //                       fontFamily: AssetFonts.roboto,
        //                       fontWeight: FontWeight.w400,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           AuthFormButton(
        //               constraints: constraints,
        //               text: "LOGIN",
        //               buttonColor: const Color(0xFF1B1E2E),
        //               onPressed: () {
        //                 // context.go(Dashboard.routePath);
        //               }),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 20.0),
        //             child: SignUpTab(
        //               size: size,
        //               constraints: constraints,
        //               signUpFunction: () {
        //                 context.push(SignupScreen.routePath);
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   );
        // }),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            height: size.height - 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Align(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: const Image(
                    image: AssetImage(ImageAssets.loginImg),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login Here",
                style: TextStyle(
                  fontFamily: AssetFonts.inter,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text("Email : ",
                    style: TextStyle(
                        fontFamily: AssetFonts.inter,
                        fontWeight: FontWeight.w600)),
              ),
              CustomTextField(
                  maxlines: 1,
                  enable: false,
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                  controller: _emailController,
                  hint: "mytest12_soe@jnu.ac.in"),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text("Password : ",
                    style: TextStyle(
                        fontFamily: AssetFonts.inter,
                        fontWeight: FontWeight.w600)),
              ),
              PasswordTextField(
                  prefixIcon:
                      const Icon(Icons.password, color: Colors.blue),
                      trailing: IconButton(
                  icon: (passwordVisible)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility_rounded,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                isObscure: !passwordVisible,
                  enable: true,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  hint: "Password"),
              const SizedBox(height: 20),
              Align(
                child: CommonButton(
                  isLoading: isLoading,
                    onTap: _submitDetails,
                    text: "Login",
                    size: size,
                    width: size.width * 0.5),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
