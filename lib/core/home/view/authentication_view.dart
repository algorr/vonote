import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';
import 'package:vonote/core/home/viewmodel/auth/auth_cubit.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: AuthenticationView());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication View'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthCubit(context.read<AuthRepository>()),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * .1),
                  child: const Center(
                    child: Text(
                      AuthViewConsts.title,
                      style: AuthViewConsts.titleTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .1,
                      right: size.width * .1,
                      top: size.height * .1),
                  child: const Center(
                    child: _EmailInputWidget(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .1, right: size.width * .1),
                  child: const Center(
                    child: _PasswordInputWidget(),
                  ),
                ),
                _LoginButtonWidget(size: size),
                _SignUpButtonWidget(size: size)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == AuthStatus.submitting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.only(top: size.height * .06,bottom: size.height * .01),
                child: SizedBox(
                    width: size.width * .5,
                    height: size.height * .04,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().loginWithEmailAndPassword();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(size.width * .5, size.height * .04)),
                      child: const Text('Login'),
                    )),
              );
      },
    );
  }
}

class _SignUpButtonWidget extends StatelessWidget {
  const _SignUpButtonWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == AuthStatus.submitting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.only(left : size.height * .06, right: size.height * .06 ),
                child: SizedBox(
                    width: size.width * .5,
                    height: size.height * .04,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().signUpWithEmailAndPassword();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(size.width * .5, size.height * .04)),
                      child: const Text('Sign Up'),
                    )),
              );
      },
    );
  }
}


class _PasswordInputWidget extends StatelessWidget {
  const _PasswordInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (password) {
            context.read<AuthCubit>().changePassword(password);
          },
          decoration: const InputDecoration(
            
              prefixIcon: Icon(Icons.password),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
        );
      },
    );
  }
}

class _EmailInputWidget extends StatelessWidget {
  const _EmailInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<AuthCubit>().changeEmail(email);
          },
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
        );
      },
    );
  }
}

class AuthViewConsts {
  static const String title = 'Register';
  static const TextStyle titleTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red);
}
