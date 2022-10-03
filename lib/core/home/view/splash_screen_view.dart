import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/app/routes/routes.dart';
import 'package:vonote/app/viewmodel/app/app_bloc.dart';


class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  static Page get page => const MaterialPage<void>(child: SplashScreenView());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.red),
          home: Scaffold(
            body: EasySplashScreen(
              logo: Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              loaderColor: Colors.red.shade800,
              logoWidth: 250,
              title: const Text(
                "Simplier Way of Splash Screen",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              backgroundColor: Colors.black38,
              showLoader: false,
              loadingText: const Text("Please Wait..."),
              navigator: FlowBuilder(
                state: context.select(
                  (AppBloc bloc) => bloc.state.status,
                ),
                onGeneratePages: (AppStatus state, List<Page<dynamic>> pages) {
                 return  OnGenerateViews(state, pages);
                },
              ),
              durationInSeconds: 5,
            ),
          ),
        );
      },
    );
  }
}
