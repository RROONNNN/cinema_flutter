
import 'package:flutter/material.dart';

abstract class ThemeState   {
  ThemeMode get themeMode => ThemeMode.system;
}

class ThemeLoading extends ThemeState {}

class ThemeLoaded extends ThemeState {
  @override
  final ThemeMode themeMode;
  ThemeLoaded(this.themeMode);
}

class ThemeError extends ThemeState {
  final String message;
  ThemeError(this.message);
}