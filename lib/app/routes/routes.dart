import 'package:flutter/material.dart';
import 'package:vonote/app/viewmodel/app/app_bloc.dart';
import 'package:vonote/core/home/view/authentication_view.dart';
import 'package:vonote/core/home/view/speech_to_text_view.dart';


List<Page<dynamic>> onGenerateViews(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [SpeechToTextView.page()];
    case AppStatus.unauthenticated:
      return [AuthenticationView.page()];
  }
}
