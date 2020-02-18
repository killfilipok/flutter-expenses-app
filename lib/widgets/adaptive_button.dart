import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );

    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: textWidget,
          )
        : FlatButton(
            onPressed: handler,
            child: textWidget,
          );
  }
}
