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
          home: const Scaffold(
            body: CustomSplashScreenAndFlowBuilder(),
          ),
        );
      },
    );
  }
}

class CustomSplashScreenAndFlowBuilder extends StatelessWidget {
  const CustomSplashScreenAndFlowBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/images/logo.png',
        width: SplashScreenConsts.imageWidth,
        height: SplashScreenConsts.imageHeight,
      ),
      loaderColor: Colors.red.shade800,
      logoWidth: SplashScreenConsts.logoWidth,
      title: const Text(
        SplashScreenConsts.title,
        style: SplashScreenConsts.titleStyle,
      ),
      backgroundColor: Colors.black38,
      showLoader: false,
      loadingText: const Text(SplashScreenConsts.loadingTitle),
      navigator: FlowBuilder(
        state: context.select(
          (AppBloc bloc) => bloc.state.status,
        ),
        onGeneratePages: (AppStatus state, List<Page<dynamic>> pages) {
          return onGenerateViews(state, pages);
        },
      ),
      durationInSeconds: 5,
    );
  }
}

class SplashScreenConsts {
  static const String title = 'The Simplier Way of Splash Screen';
  static const String loadingTitle = 'Please Wait..';
  static const TextStyle titleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static const double logoWidth = 250;
  static const double imageWidth = 200;
  static const double imageHeight = 200;
}
