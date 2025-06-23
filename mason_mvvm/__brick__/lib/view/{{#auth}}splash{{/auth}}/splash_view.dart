import 'package:flutter/material.dart';

import '../../../view_model/injection/injection_container.dart';
import '../../../view_model/{{#auth}}splash{{/auth}}/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    getIt<SplashViewModel>().checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash screen',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
