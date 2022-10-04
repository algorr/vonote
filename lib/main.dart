import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/app/viewmodel/app/app_bloc.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';
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
      child: BlocProvider(
          create: (_) => AppBloc(authRepository: _authRepository),
          child: const App()),
    );
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
          home:  FlowBuilder<AppStatus>(
            state: context.select((AppBloc bloc) => bloc.state.status),
            onGeneratePages: onGenerateViews,),
        );
  }
}
