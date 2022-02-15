# Riverpod Messages Listener

Hello all, this is the home page of **riverpod_messages** package, a message notification listener for apps build with Riverpod.


# Who is this package for

This package is useful for **displaying error or information messages** to the user sent from our StateNotifiers o ChangeNotifiers.

Some of the way this package can be used are:

### Error handling (local or global)

This package is helpful for **manage all the exceptions** that can be thrown across our *StateNotifiers* or *ChangeNotifiers* for example for internal errors or api calls.
Automatically this package listen the notifier and knows when to show a message to the user.

![error](https://user-images.githubusercontent.com/47910896/154097732-005a10a3-f9ad-4411-8c34-48b790f6b7be.gif)


### In app notifications

If we want to send a success message or a notification to the user from our notifiers this package can help us. Thanks to Riverpod it doesn't matter from where we send the message, this will be displayed to the user.

![info](https://user-images.githubusercontent.com/47910896/154097792-8ef1d20b-0013-4657-a04a-7a4f6b41ec99.gif)

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
