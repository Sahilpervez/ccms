import 'package:ccms/src/feature/auth/controllers/auth_controller.dart';
import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/feature/auth/views/widgets/custom_text_field.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class EnrollmentScreen extends ConsumerStatefulWidget {
  const EnrollmentScreen({super.key});

  static const String routePath = "/enrollment";

  @override
  ConsumerState<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends ConsumerState<EnrollmentScreen> {
  final TextEditingController controller = TextEditingController();

  void verify() {
    final enrollmentId = controller.text;
    if (enrollmentId.isEmpty) {
      SnackBarService.showSnackBar(
          context: context, message: "Please enter the Enrollment Number.");
      return;
    }
    if (enrollmentId[2] != '/' ||
        enrollmentId[5] != '/' ||
        enrollmentId[8] != '/') {
      SnackBarService.showSnackBar(
          context: context,
          message: "Enter the Enrollment Number in CORRECT FORMAT.");
      return;
    }
    ref.read(authControllerProvider.notifier).registerEnrollmentNumber(
          enrollmentNumber: controller.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height - 40,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: size.width * 0.22,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                              tag: "main_logo",
                              child:
                                  Image(image: AssetImage(ImageAssets.mainLogo))),
                          SizedBox(width: 20),
                          Text("CCMS",
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.w600)),
                        ],
                      )),
                  LottieBuilder.asset(
                    AnimationAssets.formLogin,
                    repeat: false,
                    height: 250,
                  ),
                  const Text(
                    "Verify your Enrollment ID ",
                    style: TextStyle(
                      fontFamily: AssetFonts.poppins,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: controller,
                    hint: "21/11/EC/100",
                    maxlines: 1,
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                    size: MediaQuery.of(context).size,
                    onTap: verify,
                    isLoading: isLoading,
                    text: "Verify",
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
