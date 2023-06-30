import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/widgets/navigate_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool?> alertWidget({
  required int marks,
  required BuildContext context,
  required List<Widget> scoreKeeper ,
}) =>
    Alert(
      context: context,
      type: AlertType.success,
      title: "The Test is over",
      desc: "Exam questions are over .. \n result : $marks / 5 ",
      style: const AlertStyle(
        descStyle: TextStyle(
          fontSize: 20 ,
          fontWeight: FontWeight.bold ,
        ),
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold ,
          fontSize: 24 ,
        ),
      ),
      content: Row(
        children: scoreKeeper,
      ),
      buttons: [
        DialogButton(
          onPressed: () => navigatePushReplacement(context: context, nextScreen: const HomePage()),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Back to the Home page",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
