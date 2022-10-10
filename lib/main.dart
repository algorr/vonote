import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/app/viewmodel/app/app_bloc.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';
import 'package:vonote/core/data/repositories/speech_repository.dart';
import 'package:vonote/core/home/viewmodel/auth/auth_cubit.dart';
import 'package:vonote/core/home/viewmodel/speech/cubit/speech_cubit.dart';
import 'app/bloc_observer.dart';
import 'app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();
  await authRepository.user.first;
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: const AppMultiBlocProvider(),
    );
  }
}

class AppMultiBlocProvider extends StatelessWidget {
  const AppMultiBlocProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context)=> AppBloc(authRepository: context.read<AuthRepository>())),
      BlocProvider(
          create: ((context) => AuthCubit(context.read<AuthRepository>()))),
      BlocProvider(
          create: ((context) =>
              SpeechCubit(context.read<SpeechRepository>()))),
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AppFlowBuilder(),
    );
  }
}

class AppFlowBuilder extends StatelessWidget {
  const AppFlowBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppStatus>(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateViews,
    );
  }
}
