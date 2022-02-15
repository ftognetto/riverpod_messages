
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_messages/src/change_notifier_listener_wrapper.dart';

/// A listener for [StateNotifierProvider] or [ChangeNotifierProvider] that looks for error or information message to be displayed
class MessageListener extends ConsumerWidget {

  final StateNotifierProvider? stateNotifierProvider;
  final AutoDisposeStateNotifierProvider? stateNotifierAutoDisposeProvider;
  final ChangeNotifierProvider? changeNotifierProvider;
  final AutoDisposeChangeNotifierProvider? changeNotifierAutoDisposeProvider;

  /// Function that tells [MessageListener] how to look for an error message
  /// If not specified it will look for a variable "error"
  final String? Function(dynamic)? errorExtractor;

  /// Function that tells [MessageListener] how to look for an information message
  /// If not specified it will look for a variable "info"
  final String? Function(dynamic)? infoExtractor;

  /// Child widget
  final Widget child;

  /// Function that will be called when an error message occur
  final void Function(String error) showError;

  /// Function that will be called when an info message occur
  final void Function(String info) showInfo;
  
  factory MessageListener({
    Key? key, 
    required Widget child, 
    String? Function(dynamic)? errorExtractor,
    String? Function(dynamic)? infoExtractor,
    required ProviderBase provider,
    
    required void Function(String error) showError, 
    required void Function(String error) showInfo,
  }) {
    if (provider is StateNotifierProvider) {
      return MessageListener._stateNotifier(child: child, provider: provider, showError: showError, showInfo: showInfo);
    }
    else if (provider is AutoDisposeStateNotifierProvider) {
      return MessageListener._autoDisposeStateNotifier(child: child, provider: provider, showError: showError, showInfo: showInfo);
    }
    else if (provider is ChangeNotifierProvider) {
      return MessageListener._changeNotifier(child: child, provider: provider, showError: showError, showInfo: showInfo);
    }
    else if (provider is AutoDisposeChangeNotifierProvider) {
      return MessageListener._autoDisposeChangeNotifier( child: child, provider: provider, showError: showError, showInfo: showInfo);
    }
    else {
      throw UnimplementedError('riverpod_messages supports only StateNotifier or ChangeNotifier');
    }
  }

  const MessageListener._stateNotifier({
    Key? key, 
    required this.child, 
    this.errorExtractor,
    this.infoExtractor,
    required StateNotifierProvider provider,
    
    required this.showError, 
    required this.showInfo,
  }) : 
    // ignore: prefer_initializing_formals
    stateNotifierProvider = provider,
    stateNotifierAutoDisposeProvider = null,
    changeNotifierProvider = null,
    changeNotifierAutoDisposeProvider = null,
    super(key: key);

  const MessageListener._autoDisposeStateNotifier({
    Key? key, 
    required this.child, 
    this.errorExtractor,
    this.infoExtractor,
    required AutoDisposeStateNotifierProvider provider,
    required this.showError, 
    required this.showInfo,
  }) : 
    stateNotifierProvider = null,
    stateNotifierAutoDisposeProvider = provider,
    changeNotifierProvider = null,
    changeNotifierAutoDisposeProvider = null,
    super(key: key);

  const MessageListener._changeNotifier({
    Key? key, 
    required this.child, 
    this.errorExtractor,
    this.infoExtractor,
    required ChangeNotifierProvider provider,
    
    required this.showError, 
    required this.showInfo,
  }) : 
    // ignore: prefer_initializing_formals
    stateNotifierProvider = null,
    stateNotifierAutoDisposeProvider = null,
    changeNotifierProvider = provider,
    changeNotifierAutoDisposeProvider = null,
    super(key: key);

  const MessageListener._autoDisposeChangeNotifier({
    Key? key, 
    required this.child, 
    this.errorExtractor,
    this.infoExtractor,
    required AutoDisposeChangeNotifierProvider provider,
    
    required this.showError, 
    required this.showInfo,
  }) : 
    // ignore: prefer_initializing_formals
    stateNotifierProvider = null,
    stateNotifierAutoDisposeProvider = null,
    changeNotifierProvider = null,
    changeNotifierAutoDisposeProvider = provider,
    super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   Widget _child = child;

    // State notifiers
    if (stateNotifierProvider != null || stateNotifierAutoDisposeProvider != null) {
      ref.listen(stateNotifierProvider ?? stateNotifierAutoDisposeProvider!, (dynamic old, dynamic value) {
        String? error;
        String? oldError;
        if (errorExtractor != null) { error = errorExtractor!(value);}
        else { error = _defaultErrorExtractor(value); }
        if (old != null) {
          if (errorExtractor != null) { oldError = errorExtractor!(old);}
          else { oldError = _defaultErrorExtractor(old); }
        }
        if (error != null && error != oldError) {
          _handleError(context, error);
        }

        String? info;
        String? oldInfo;
        if (infoExtractor != null) { info = infoExtractor!(value);}
        else { info = _defaultInfoExtractor(value); }
        if (old != null) {
          if (infoExtractor != null) { oldInfo = infoExtractor!(old);}
          else { oldInfo = _defaultInfoExtractor(old); }
        }
        if (info != null && info != oldInfo) {
          _handleInfo(context, info);
        }
      });
    }


    // Change notifiers
    // This needs a wrapper, because ref.listen will not have the previous state to compare
    if (changeNotifierProvider != null || changeNotifierAutoDisposeProvider != null) {
      _child = ChangeNotifierListenerWrapper(
        child: _child, 
        provider: changeNotifierProvider ?? changeNotifierAutoDisposeProvider!, 
        errorExtractor: errorExtractor ?? _defaultErrorExtractor,
        infoExtractor: infoExtractor ?? _defaultInfoExtractor,
        errorListener: (oldError, error) {
          if (error != null && error != oldError) {
            _handleError(context, error);
          }
        },
        infoListener: (oldInfo, info) {
          if (info != null && info != oldInfo) {
            _handleInfo(context, info);
          }
        }
      );
    }
    
    return _child;
    
  }

  void _handleError(BuildContext context, String error) {
    if (ModalRoute.of(context)!.isCurrent){
      showError(error);
    }
  }

  void _handleInfo(BuildContext context, String info) {
    if (ModalRoute.of(context)!.isCurrent){
      showInfo(info);
    }
    
  }

  String? _defaultErrorExtractor(dynamic value) {
    var hasProperty = false;
    try {
      (value as dynamic).error;
      hasProperty = true;
    } on NoSuchMethodError {
      // noop
    }
    if (hasProperty && (value as dynamic).error is String && ((value as dynamic).error as String).isNotEmpty) {
      return ((value as dynamic).error as String);
    }
    return null;
  }

  String? _defaultInfoExtractor(dynamic value) {
    var hasProperty = false;
    try {
      (value as dynamic).info;
      hasProperty = true;
    } on NoSuchMethodError {
      // noop
    }
    if (hasProperty && (value as dynamic).info is String && ((value as dynamic).info as String).isNotEmpty) {
      return ((value as dynamic).info as String);
    }
    return null;
  }

}
