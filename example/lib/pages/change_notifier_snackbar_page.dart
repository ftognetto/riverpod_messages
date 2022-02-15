import 'package:example/state/example_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_messages/riverpod_messages.dart';

class ChangeNotifierSnackbarPage extends ConsumerWidget {
  const ChangeNotifierSnackbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('State Notifier with Snackbar'),
        ),
        body: MessageSnackbarListener(
            provider: exampleChangeNotifierProvider,
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                  child: const Text('Simulate error message'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    ref.read(exampleChangeNotifierProvider.notifier).simulateError();
                  }),
              ElevatedButton(
                  child: const Text('Simulate information message'),
                  onPressed: () {
                    ref.read(exampleChangeNotifierProvider.notifier).simulateInfo();
                  }),
              ref.watch(exampleChangeNotifierProvider.select((value) => value.loading))
                  ? const CircularProgressIndicator()
                  : Container()
            ]))));
  }
}
