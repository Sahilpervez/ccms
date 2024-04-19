import 'package:ccms/src/feature/all_clubs/views/all_clubs_screen.dart';
import 'package:ccms/src/feature/auth/views/enrollment_details_screen.dart';
import 'package:ccms/src/feature/auth/views/enrollment_screen.dart';
import 'package:ccms/src/feature/auth/views/login.dart';
import 'package:ccms/src/feature/auth/views/set_password_screen.dart';
import 'package:ccms/src/feature/auth/views/signup.dart';
import 'package:ccms/src/feature/auth/views/verify_email_screen.dart';
import 'package:ccms/src/feature/calendar/views/calendar_screen.dart';
import 'package:ccms/src/feature/my_clubs/views/my_clubs_screen.dart';
import 'package:flutter/material.dart';
import 'package:ccms/src/global/views/splash.dart';
import 'package:ccms/src/feature/home/view/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: EnrollmentScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const EnrollmentScreen();
      },
    ),
    GoRoute(
      path: EnrollmentDetailsScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final params = state.extra as Map<String,String>;
        return EnrollmentDetailsScreen(params : params);
      },
    ),
    GoRoute(
      path: VerifyEmailScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final params = state.extra as Map<String,String>;
        return VerifyEmailScreen(params : params);
      },
    ),
    GoRoute(
      path: SetPasswordScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final params = state.extra as Map<String,String>;
        return SetPasswordScreen(params : params);
      },
    ),
    GoRoute(
      path: LoginScreen.routePath,
      pageBuilder: (BuildContext context,GoRouterState state) {
        final params = state.extra as Map<String,String>;
        return customTransition(renderPage: LoginScreen(params: params));
      },
    ),
    GoRoute(
      path: SignupScreen.routePath,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return customTransition(renderPage: const SignupScreen());
      },
    ),


    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: AllClubsScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const AllClubsScreen();
      },
    ),
    GoRoute(
      path: MyClubsScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const MyClubsScreen();
      },
    ),
    GoRoute(
      path: CalendarScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const CalendarScreen();
      },
    ),


  ],
);

CustomTransitionPage<dynamic> customTransition({required Widget renderPage}) {
  return CustomTransitionPage(
        child: renderPage,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuad;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}