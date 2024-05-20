import 'package:flutter/material.dart';
import 'splash_cubit.dart';

class SplashPage extends StatefulWidget {
  final SplashCubit cubit;

  const SplashPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  SplashCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
