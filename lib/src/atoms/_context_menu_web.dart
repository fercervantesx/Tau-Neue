import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// Prevents the browser's default context menu for web platforms.
void preventDefaultContextMenu() {
  web.document.addEventListener('contextmenu', ((web.Event event) {
    event.preventDefault();
  }).toJS);
}

/// No-op for initialization on web.
void initializeContextMenu() {
  preventDefaultContextMenu();
}
