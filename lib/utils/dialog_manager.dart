import 'package:flutter/material.dart';
import 'package:tezda_app/widgets/loading_screen.dart';

import 'dialog_handler.dart';
import 'locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({super.key, required this.child});

  @override
  DialogManagerState createState() => DialogManagerState();
}

class DialogManagerState extends State<DialogManager> {
  late DialogHandler _dialogHandler;
  OverlayEntry? _overlayEntry;
  final List<OverlayEntry> _overlayEntries = [];

  void addOverlay(OverlayEntry entry) {
    _overlayEntries.add(entry);
  }

  void removeAllOverlays() {
    for (final entry in _overlayEntries) {
      if (entry.mounted) entry.remove();
    }
    _overlayEntries.clear();
  }

  @override
  void initState() {
    super.initState();
    _dialogHandler = locator<DialogHandler>();
    _dialogHandler.registerProgressDialogListener(showProgressDialog);
    _dialogHandler.registerDismissDialogListener(dismissDialog);
  }

  void showProgressDialog({String? message}) {
    // dismissDialog();
    _overlayEntry = OverlayEntry(
      builder: (context) => LoadingScreen(
        message: message,
        onCancel: () {
          dismissDialog();
        },
      ),
    );
    addOverlay(_overlayEntry!);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void dismissDialog() {
    removeAllOverlays();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
