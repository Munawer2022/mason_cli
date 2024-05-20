import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/models/auth/login/login_model.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  final LoginCubit cubit;

  const LoginPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  LoginCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            state as LoginState;
            if (state.error != null) {
              return Text(
                state.error!,
                textAlign: TextAlign.center,
              );
            }

            return Column(
              children: [
                state.isloading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => cubit.postLogin(
                            body: LoginModel(email: '', password: '').toJson()),
                        child: const Text('Post API')),
                Text(state.success.token,
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            );
          },
        ),
      ),
    );
  }
}
