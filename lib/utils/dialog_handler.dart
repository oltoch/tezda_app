abstract class DialogHandler {
  ///Registers a callback to show top toast dialog
  void registerProgressDialogListener(
      Function({String? message}) progressDialog);

  void registerDismissDialogListener(Function() dismissDialog);

  ///Display top toast dialog on the screen

  dynamic showProgressDialog({String? message});

  void closeDialog();
}

class DialogHandlerImpl implements DialogHandler {
  late Function({String? message}) _progressDialog;

  late Function() _dismissDialog;

  @override
  void registerProgressDialogListener(
      Function({String? message}) progressDialog) {
    _progressDialog = progressDialog;
  }

  @override
  void registerDismissDialogListener(Function() dismissDialog) {
    _dismissDialog = dismissDialog;
  }

  @override
  dynamic showProgressDialog({String? message}) {
    return _progressDialog(message: message);
  }

  @override
  void closeDialog() {
    _dismissDialog();
  }
}
