



// importacion del cupertni oy la de amteria


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
 required String cancelActionText,
  required String defaultActionText,
}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          // if (cancelActionText != null)
          //   TextButton(
          //     child: Text(cancelActionText),
          //     onPressed: () => Navigator.of(context).pop(false),
          //   ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  // todo : showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          // CupertinoDialogAction(
          //   child: Text(cancelActionText),
          //   onPressed: () => Navigator.of(context).pop(false),
          // ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
