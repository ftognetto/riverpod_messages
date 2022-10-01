import 'package:example/pages/change_notifier_overlay_page.dart';
import 'package:example/pages/change_notifier_snackbar_page.dart';
import 'package:example/pages/state_notifier_overlay_page.dart';
import 'package:example/pages/state_notifier_snackbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          snackBarTheme:
              const SnackBarThemeData(behavior: SnackBarBehavior.floating)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Messages example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: const Text('State notifier with Snackbar'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StateNotifierSnackbarPage()));
                }),
            ElevatedButton(
                child: const Text('State notifier with Overlay'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StateNotifierOverlayPage()));
                }),
            ElevatedButton(
                child: const Text('Change notifier with Snackbar'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ChangeNotifierSnackbarPage()));
                }),
            ElevatedButton(
                child: const Text('Change notifier with Overlay'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangeNotifierOverlayPage()));
                })
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         const SizedBox(height: 24,),
    //         MessageSnackbarListener(
    //           provider: exampleStateNotifierProvider,
    //           child: Column(
    //             children: [
    //               const Text('State Notifier with Snackbar'),
    //               ElevatedButton(
    //                 child: const Text('Simulate error message'),
    //                 style: ElevatedButton.styleFrom(primary: Colors.red),
    //                 onPressed: (){
    //                   ref.read(exampleStateNotifierProvider.notifier).simulateError();
    //                 }
    //               ),
    //               ElevatedButton(
    //                 child: const Text('Simulate information message'),
    //                 onPressed: (){
    //                   ref.read(exampleStateNotifierProvider.notifier).simulateInfo();
    //                 }
    //               ),
    //             ],
    //           )
    //         ),
    //         const SizedBox(height: 24,),
    //         MessageOverlayListener(
    //           provider: exampleStateNotifierProvider,
    //           child: Column(
    //             children: [
    //               const Text('State Notifier with Overlay'),
    //               ElevatedButton(
    //                 child: const Text('Simulate error message'),
    //                 style: ElevatedButton.styleFrom(primary: Colors.red),
    //                 onPressed: (){
    //                   ref.read(exampleStateNotifierProvider.notifier).simulateError();
    //                 }
    //               ),
    //               ElevatedButton(
    //                 child: const Text('Simulate information message'),
    //                 onPressed: (){
    //                   ref.read(exampleStateNotifierProvider.notifier).simulateInfo();
    //                 }
    //               ),
    //             ],
    //           )
    //         ),
    //         const SizedBox(height: 24,),
    //         MessageSnackbarListener(
    //           provider: exampleChangeNotifierProvider,
    //           child: Column(
    //             children: [
    //               const Text('Change Notifier with Snackbar'),
    //               ElevatedButton(
    //                 child: const Text('Simulate error message'),
    //                 style: ElevatedButton.styleFrom(primary: Colors.red),
    //                 onPressed: (){
    //                   ref.read(exampleChangeNotifierProvider.notifier).simulateError();
    //                 }
    //               ),
    //               ElevatedButton(
    //                 child: const Text('Simulate information message'),
    //                 onPressed: (){
    //                   ref.read(exampleChangeNotifierProvider.notifier).simulateInfo();
    //                 }
    //               )
    //             ],
    //           )
    //         ),
    //       ],
    //     ),
    //   )

    // );
  }
}
