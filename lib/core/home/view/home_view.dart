
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';
import 'package:vonote/core/home/view/speech_to_text_view.dart';
import 'package:vonote/core/home/viewmodel/auth/auth_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeView());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(' Home View'),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().logOut();
                  },
                  icon: const Icon(Icons.exit_to_app),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
          
          },
        ),
        body: const SpeechToTextView(),
      ),
    );
  }
}
