import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light()) {
    _getPreferences();
  }
  SharedPreferences? _preferences;
  final String key = "theme";

  bool get isLightTheme => state.brightness == Brightness.light;

  void toggleTheme() {
    if (isLightTheme) {
      emit(ThemeData.dark());
    } else {
      emit(ThemeData.light());
    }
    _savePreferences(isLightTheme);
  }

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences(bool isLightTheme) async {
    await _initialPreferences();
    _preferences!.setBool(key, isLightTheme);
  }

  _getPreferences() async {
    await _initialPreferences();
    final isLightTheme = _preferences!.getBool(key) ?? true;

    if (isLightTheme) {
      emit(ThemeData.light());
    } else {
      emit(ThemeData.dark());
    }
  }
}
