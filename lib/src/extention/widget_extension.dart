// ignore_for_file: document_ignores

import 'package:flutter/widgets.dart';
import 'package:cerbere/cerbere.dart';

// ignore: public_member_api_docs
extension CerbereWidgetExtension on Widget {
  // ignore: public_member_api_docs
  Widget cerbereVerifie(
    String cle, {
    Widget? deniedWidget,
    Widget? loadingWidget,
  }) {
    return CerbereWidgetVerifie(
      cle: cle,
      deniedWidget: deniedWidget,
      loadingWidget: loadingWidget,
      child: this,
    );
  }
}
