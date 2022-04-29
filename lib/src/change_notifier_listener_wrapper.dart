import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeNotifierListenerWrapper extends ConsumerStatefulWidget {
  final Widget child;
  final ProviderBase provider;
  final void Function(String?, String?) errorListener;
  final void Function(String?, String?) infoListener;
  final String? Function(dynamic) errorExtractor;
  final String? Function(dynamic) infoExtractor;

  const ChangeNotifierListenerWrapper(
      {required this.child,
      required this.provider,
      required this.errorExtractor,
      required this.infoListener,
      required this.errorListener,
      required this.infoExtractor,
      Key? key})
      : super(key: key);

  @override
  _ChangeNotifierListenerWrapperState createState() =>
      _ChangeNotifierListenerWrapperState();
}

class _ChangeNotifierListenerWrapperState<T>
    extends ConsumerState<ChangeNotifierListenerWrapper> {
  String? oldError;
  String? oldInfo;

  @override
  Widget build(BuildContext context) {
    ref.listen(widget.provider, (dynamic previous, dynamic next) {
      final error = widget.errorExtractor(next);
      widget.errorListener(oldError, error);
      oldError = error;

      final info = widget.infoExtractor(next);
      widget.infoListener(oldInfo, info);
      oldInfo = info;
    });
    return widget.child;
  }
}
