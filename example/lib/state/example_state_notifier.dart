

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleStateNotifierState {
  final String? error;
  final String? info;
  /// .... other properties of the state
  final bool loading;

  const ExampleStateNotifierState({this.loading = false, this.error, this.info});

  ExampleStateNotifierState copyWith({
    String? error,
    String? info,
    bool? loading
  }) {
    return ExampleStateNotifierState(
      error: error ?? this.error,
      info: info ?? this.info,
      loading: loading ?? this.loading
    );
  }

}

class ExampleStateNotifier extends StateNotifier<ExampleStateNotifierState> {
  ExampleStateNotifier(): super(const ExampleStateNotifierState());

  Future<void> simulateError() async {
    state = state.copyWith(loading: true, error: '');

    // simulate a job
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(loading: false, error: 'Ooops! An error has occurred! [StateNotifier]');
  }

  Future<void> simulateInfo() async {
    state = state.copyWith(loading: true, info: '');

    // simulate a job
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(loading: false, info: 'You received a new message! [StateNotifier]');
  }
}

final exampleStateNotifierProvider = StateNotifierProvider<ExampleStateNotifier, ExampleStateNotifierState>((_) => ExampleStateNotifier());