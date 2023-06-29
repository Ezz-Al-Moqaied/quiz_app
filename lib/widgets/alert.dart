import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool?> alertWidget({
  required int marks,
  required BuildContext context,
  required List<Widget> scoreKeeper ,
}) =>
    Alert(
      context: context,
      type: AlertType.success,
      title: "RFLUTTER ALERT",
      desc: "Exam questions are over.. $marks / 5 ",
      content: Row(
        children: scoreKeeper,
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "exam REPETITON",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
