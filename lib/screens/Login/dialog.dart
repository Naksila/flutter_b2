import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              title: Text(string),
            ),
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('Ok'))
            ],
          ));
}
