import 'package:flutter/material.dart';
import 'package:ccms/src/utils/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData().copyWith(
        primaryColor: Colors.amber,
      ),
    );
  }
}
