import 'dart:developer';

import 'package:ccms/src/feature/auth/views/enrollment_screen.dart';
import 'package:ccms/src/feature/home/view/home.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/global/controller/init_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/utils/config.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    /// check if the app is running in dev mode
    if (AppConfig.devMode) {
      /// bypass authenticaion logic.
      /// Navigate to Home
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.go(EnrollmentScreen.routePath);
        // context.go(HomeView.routePath);
      });
    } else {

      ref.read(initControllerProvider).initUserAndToken().then((value){
        final user = ref.read(currentUserProvider);
        final token = ref.read(authTokenProvider);

        if(token != null && user == null){
          /// Route the user to Home screen and Get the user from server.
          // TODO: Write logic to get user before routing Or in the home screen.
          context.go(HomeView.routePath,extra: {'getUser' : true});
        }else if(token == null && user != null){
          /// Route the user to Authentication screen.
          log("token == null && user != null",name: "Splash Screen Redirect");
        }
        /// Check if both the [user] and [token] have value.
        else if(user == null && token == null){
          /// Route the user to Authenticaion screen.
          log("user == null && token == null",name: "Splash Screen Redirect");
          context.go(EnrollmentScreen.routePath);
        } else {
          /// Route the user to Home screen.
          // context.go(EnrollmentScreen.routePath);
          context.go(HomeView.routePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.blue,
      body: Center(
        child: 
          Padding(
            padding: EdgeInsets.all(60.0),
            child: Hero(
                tag: "main_logo",
                child: Image(image: AssetImage(ImageAssets.mainLogo))),
          ),
      ),
    );
  }
}
