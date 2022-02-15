# Riverpod Messages Listener

Hello all, this is the home page of **riverpod_messages** package, a message notification listener for apps build with Riverpod.


# Who is this package for

This package is useful for **displaying error or information messages** to the user sent from our StateNotifiers o ChangeNotifiers.

Some of the way this package can be used are:

### Error handling (local or global)

This package is helpful for **manage all the exceptions** that can be thrown across our *StateNotifiers* or *ChangeNotifiers* for example for internal errors or api calls.
Automatically this package listen the notifier and knows when to show a message to the user.

> We can use as many as MessageListener we want, so we could use a MessageListener for every Notifier or we can make a global error handling by creating an appropriate notifier and then wrap the whole app with MessageListener


<img src="https://user-images.githubusercontent.com/47910896/154097732-005a10a3-f9ad-4411-8c34-48b790f6b7be.gif" width="250" />


### In app notifications

If we want to send a success message or a notification to the user from our notifiers this package can help us. Thanks to Riverpod it doesn't matter from where we send the message, this will be displayed to the user.


<img src="https://user-images.githubusercontent.com/47910896/154097792-8ef1d20b-0013-4657-a04a-7a4f6b41ec99.gif" width="250" />

# How it works

This package expose a widget, the **MessageListener** which ask us for a provider that can be a  *StateNotifierProvider* or a *ChangeNotifierProvider* and provide us two methods to do something when an error occur or when an information message gets generated.

**Internally this widget looks for a variable called "error" for displaying errors and a variable called "info" for displaying informations** and it will search for this variable inside the State in case of StateNotifier or inside the class in case of ChangeNotifier.

> **This behavior can be customized** using the method "**errorExtractor**" and
> "**infoExtractor**" exposed by the **MessageListener** with which we can tell the MessageListener how to search the error and information to display

In this way this package does not enforce our way to write State/Change Notifiers with mixins or abstract classes, but it try to find the messages to display automatically.

# UI

This package give use already two implementations of the **MessageListener** widget

 - The **MessageSnackbarListener** that will use a Snackbar to display the messages
 - The **MessageOverlayListener** that will use the Overlay api to display messages

Of course you can fork and send PRs if you want to use other way to display messages! It's just a matter of wrap **MessageListener** and customize *showError* and *showInfo* methods!

# Examples

You can download the project and run example project inside

### StateNotifier

This is a sample StateNotifier

```
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
```

And then in your page

```
class StateNotifierSnackbarPage extends ConsumerWidget {
  const StateNotifierSnackbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('State Notifier with Snackbar'),
        ),
        body: MessageSnackbarListener( // This is the listener
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
```