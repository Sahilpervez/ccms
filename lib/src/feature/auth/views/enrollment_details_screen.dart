import 'package:ccms/src/feature/auth/controllers/auth_controller.dart';
import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/feature/auth/views/widgets/custom_text_field.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class EnrollmentDetailsScreen extends ConsumerStatefulWidget {
  const EnrollmentDetailsScreen({super.key, required this.params});

  static const routePath = "/enrollment_details_screen";
  final Map<String, String> params;

  @override
  ConsumerState<EnrollmentDetailsScreen> createState() =>
      _EnrollmentDetailsScreenState();
}

class _EnrollmentDetailsScreenState
    extends ConsumerState<EnrollmentDetailsScreen> {
  final emailController = TextEditingController();
  final enrollmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final enrollmentNo = widget.params['enrollment_number'];
    enrollmentController.text = enrollmentNo!;
  }

  void _submitDetails(){
    final email = emailController.text;
    if(email.isEmpty){
      SnackBarService.showSnackBar(context: context, message: "Email ID is mandatory");
      return ;
    }
    if(!(email.contains("@jnu.ac.in"))){
      SnackBarService.showSnackBar(context: context, message: "Enter a valid Email ID");
      return ;
    }
    ref.read(authControllerProvider.notifier).sendVerificationMail(email:email, context: context);
  }

  @override
  Widget build(BuildContext context) {
    String name = "John Doe";
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height - 80,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LottieBuilder.asset(
                    AnimationAssets.loginLady,
                    height: size.width * 0.55,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Hello ",
                            style: TextStyle(
                              fontFamily: AssetFonts.inter,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: name,
                            style: const TextStyle(
                              fontFamily: AssetFonts.inter,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ),
                          const TextSpan(
                            text: ",",
                            style: TextStyle(
                              fontFamily: AssetFonts.inter,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "Enter your details here.",
                    style: TextStyle(
                      fontFamily: AssetFonts.inter,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Text("Email : ",
                        style: TextStyle(
                            fontFamily: AssetFonts.inter,
                            fontWeight: FontWeight.w600)),
                  ),
                  CustomTextField(
                    maxlines: 1,
                      prefixIcon: const Icon(Icons.email, color: Colors.blue),
                      controller: emailController,
                      hint: "mytest12_soe@jnu.ac.in"),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Text("Enrollment Number : ",
                        style: TextStyle(
                            fontFamily: AssetFonts.inter,
                            fontWeight: FontWeight.w600)),
                  ),
                  CustomTextField(
                      prefixIcon: const Icon(Icons.format_align_center, color: Colors.blue),
                      enable: false,
                      controller: enrollmentController,
                      hint: "21/11/EC/100"),
                    
                  const SizedBox(height: 20), 
                  Align(
                    child: CommonButton(
                          onTap: _submitDetails,
                          text: "Signup",
                          size: size,
                          width: size.width * 0.5
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
