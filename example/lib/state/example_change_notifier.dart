
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleChangeNotifier extends ChangeNotifier {

  String? error;
  String? info;
  bool loading = false;

  ExampleChangeNotifier({ this.error, this.info });

  Future<void> simulateError() async {
    error = null;
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    error = 'Oooops! An error has occurred [ChangeNotifier]';
    loading = false;
    notifyListeners();
  }

  Future<void> simulateInfo() async {
    error = null;
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    info = 'You received a new message! [ChangeNotifier]';
    loading = false;
    notifyListeners();
  }

}

final exampleChangeNotifierProvider = ChangeNotifierProvider((_) => ExampleChangeNotifier());