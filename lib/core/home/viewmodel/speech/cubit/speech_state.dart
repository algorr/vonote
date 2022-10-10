part of 'speech_cubit.dart';

enum Speechstatus { initial, submitting, success, error }

class SpeechState extends Equatable {
  const SpeechState();

  @override
  List<Object> get props => [];
}

class SpeechInitial extends SpeechState {}

class SpeechLoadingState extends SpeechState {}

class SpeechLoadedState extends SpeechState {
  final List<Speech>? apiResult;

  const SpeechLoadedState(this.apiResult);
}
