import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/model/multipe_choice/quizBrainMultiple.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/widgets/alert.dart';
import 'package:quiz_app/widgets/my_outline_btn.dart';
import 'package:quiz_app/widgets/navigate_widget.dart';

class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  QuizBrainMulti quizBrainMulti = QuizBrainMulti();
  List<Icon> scoreKeeper = [];
  int counter = 10;
  int mark = 0;
  bool isAlert = false;

  void checkAnswer(int index) {
    int correct = quizBrainMulti.getQuestionAnswer();
    setState(() {
      if (correct == index) {
        correctAnswer();
      } else {
        wrongAnswer();
      }
    });

    if (quizBrainMulti.isFinished()) {
      alertWidget(marks: mark, context: context, scoreKeeper: scoreKeeper);

      Timer timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          isAlert = true;
          quizBrainMulti.reset();
          scoreKeeper.clear();
        });
      });
      timer.cancel();
    } else {
      counter = 10;
      quizBrainMulti.nextQuestion();
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
        quizBrainMulti.nextQuestion();
        if (quizBrainMulti.isFinished()) {
          if (!isAlert) {
            alertWidget(
                marks: mark, context: context, scoreKeeper: scoreKeeper);
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
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        navigatePop(context: context);
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
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              Text(
                'question ${quizBrainMulti.getQuestionNember()} of ${quizBrainMulti.getAllQuestionsNember()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                quizBrainMulti.getQuestionText(),
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      child: ElevatedButton(
                        onPressed: () {
                          checkAnswer(index);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  quizBrainMulti.getOptions()[index],
                                  style: const TextStyle(
                                      color: kL2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.check_rounded,
                              color: kL2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: quizBrainMulti.getOptions().length,
              ),
              const SizedBox(
                height: 48,
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
      ),
    );
  }

  void correctAnswer() {
    mark = mark + 1;
    scoreKeeper.add(
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void wrongAnswer() {
    scoreKeeper.add(
      const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}
