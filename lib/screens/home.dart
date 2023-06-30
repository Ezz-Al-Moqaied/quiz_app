import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/model/level.dart';
import 'package:quiz_app/screens/level_describtion.dart';
import 'package:quiz_app/screens/multiple_q_screen.dart';
import 'package:quiz_app/screens/true_false_q_screen.dart';
import 'package:quiz_app/widgets/my_level_widget.dart';
import 'package:quiz_app/widgets/my_outline_btn.dart';
import 'package:quiz_app/widgets/navigate_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Level> levels = [
    Level("assets/images/bags.png", Icons.close, "Level 1", "True or False",
        [kL1, kL12], TrueFalseQuiz()),
    Level("assets/images/ballon-s.png", Icons.play_arrow, "Level 2",
        "Multiple Choice", [kL2, kL22], const MultiQScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          MYOutlineBtn(
            icon: Icons.favorite,
            iconColor: kBlueIcon,
            bColor: kGreyFont.withOpacity(0.5),
            function: () {
              print("favorite icon");
            },
          ),
          MYOutlineBtn(
              icon: Icons.person,
              iconColor: kBlueIcon,
              bColor: kGreyFont.withOpacity(0.5),
              function: () {
                print("person icon");
              }),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let\'s Play',
                style: TextStyle(
                  fontSize: 32,
                  color: kRedFont,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Be the First!',
                style: TextStyle(
                  fontSize: 20,
                  color: kGreyFont,
                  fontFamily: kFontFamily,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MyLevelWidget(
                    function: () {
                      navigatePush(
                          context: context,
                          nextScreen: LevelDescription(level: levels[index]));
                    },
                    icon: levels[index].icon,
                    title: levels[index].levelName,
                    subtitle: levels[index].levelNumber,
                    image: levels[index].image,
                    colors: levels[index].Colors,
                  );
                },
                itemCount: levels.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
