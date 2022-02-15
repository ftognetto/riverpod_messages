import 'package:example/state/example_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_messages/riverpod_messages.dart';

class StateNotifierOverlayPage extends ConsumerWidget {
  const StateNotifierOverlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('State Notifier with Snackbar'),
        ),
        body: MessageOverlayListener(
            provider: exampleStateNotifierProvider,
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                  child: const Text('Simulate error message'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    ref.read(exampleStateNotifierProvider.notifier).simulateError();
                  }),
              ElevatedButton(
                  child: const Text('Simulate information message'),
                  onPressed: () {
                    ref.read(exampleStateNotifierProvider.notifier).simulateInfo();
                  }),
              ref.watch(exampleStateNotifierProvider.select((value) => value.loading))
                  ? const CircularProgressIndicator()
                  : Container()
            ]))));
  }
}
