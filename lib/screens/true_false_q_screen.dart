import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/model/true_false/quizBrain.dart';
import 'package:quiz_app/widgets/alert.dart';
import 'package:quiz_app/widgets/my_outline_btn.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];
  int mark = 0;
  int counter = 10;
  bool isAlert = false ;
  void checkAnswer(bool userChoice) {
    bool correct = quizBrain.getQuestionAnswer();
    setState(() {
      if (correct == userChoice) {
        correctAnswer();
      } else {
        wrongAnswer();
      }
    });

    if (quizBrain.isFinished()) {
      alertWidget(marks: mark, context: context, scoreKeeper: scoreKeeper);
      Timer timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          isAlert = true ;
          quizBrain.reset();
          scoreKeeper.clear();
        });
      });
      timer.cancel();
    } else {
      counter = 10;
      quizBrain.nextQuestion();
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
      });
      if (counter == 0) {
        wrongAnswer();
        counter = 10;
        quizBrain.nextQuestion();
        if (quizBrain.isFinished()) {
          if(!isAlert){
            alertWidget(marks: mark, context: context, scoreKeeper: scoreKeeper);
            timer.cancel();
          }
          timer.cancel();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 44,
                  width: 44,
                  child: MYOutlineBtn(
                    icon: Icons.close,
                    iconColor: Colors.white,
                    bColor: Colors.white,
                    function: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: CircularProgressIndicator(
                        value: counter / 10,
                        color: Colors.white,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Text(
                      counter.toString(),
                      style: const TextStyle(
                        fontFamily: 'Sf-Pro-Text',
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: const BorderSide(color: Colors.white)),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              'question ${quizBrain.getQuestionNember()} of ${quizBrain.getAllQuestionsNember()}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Sf-Pro-Text',
                color: Colors.white60,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              quizBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 60),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 60),
              child: ElevatedButton(
                style: const ButtonStyle().copyWith(
                  backgroundColor: const MaterialStatePropertyAll(Colors.red),
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
              ),
            ),
            Wrap(
              children: scoreKeeper,
            ),
            const SizedBox(
              height: 72,
            )
          ],
        ),
      ),
    );
  }

  void correctAnswer (){
    mark = mark + 1;
    scoreKeeper.add(
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }
  void wrongAnswer (){
    scoreKeeper.add(
      const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}
