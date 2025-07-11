import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/store.dart';
import 'theme_event.dart';
import 'theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLoading()) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(
      LoadTheme event,
      Emitter<ThemeState> emit,
      ) async {
    try {
      final themeModeString = await Store.getThemeMode();
      ThemeMode themeMode;

      switch (themeModeString) {
        case 'dark':
          themeMode = ThemeMode.dark;
          break;
        case 'light':
          themeMode = ThemeMode.light;
          break;
        default:
          themeMode = ThemeMode.system;
      }
      emit(ThemeLoaded(themeMode));
    }
    catch (e) {
      emit(ThemeError('Failed to load theme'));
    }
  }

  Future<void> _onChangeTheme(
      ChangeTheme event,
      Emitter<ThemeState> emit,
      ) async {
    if(state is! ThemeLoaded) return;
    String themeModeString;
    switch (event.themeMode) {
      case ThemeMode.dark:
        themeModeString = "dark";
        break;
      case ThemeMode.light:
        themeModeString = "light";
        break;
      default:
        themeModeString = "system";
    }
    await Store.setThemeMode(themeModeString);
    emit(ThemeLoaded(event.themeMode));
  }
}