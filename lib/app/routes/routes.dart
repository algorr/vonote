import 'package:flutter/material.dart';
import 'package:vonote/app/viewmodel/app/app_bloc.dart';
import 'package:vonote/core/home/view/authentication_view.dart';
import 'package:vonote/core/home/view/home_view.dart';


List<Page<dynamic>> OnGenerateViews(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeView.page()];
    case AppStatus.unauthenticated:
      return [AuthenticationView.page()];
  }
}
