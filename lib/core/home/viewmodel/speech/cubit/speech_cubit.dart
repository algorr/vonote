import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/core/data/model/speech_model.dart';
import 'package:vonote/core/data/repositories/speech_repository.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechRepository _repository;
  SpeechCubit(this._repository) : super(SpeechInitial());

  Future saveUserData()async{
    _repository.saveUserData(FirebaseAuth.instance.currentUser?.uid);
    emit(SpeechLoadingState());
  }
}
