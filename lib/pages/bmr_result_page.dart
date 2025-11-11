import 'package:flutter/material.dart';
import 'package:bmi/components/custom_card.dart';
import 'package:bmi/constants.dart';
import 'package:bmi/components/bottom_button.dart';

class BMRResultPage extends StatelessWidget {
  const BMRResultPage({
    Key? key,
    required this.bmr,
    required this.calorieNeeds,
    required this.description,
  }) : super(key: key);

  final String bmr;
  final Map<ActivityLevel, String> calorieNeeds;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR RESULT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Your Result',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomCard(
              color: activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'BASAL METABOLIC RATE',
                    style: labelTextStyle,
                  ),
                  Text(
                    bmr,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Calories/day',
                    style: labelTextStyle.copyWith(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'DAILY CALORIE NEEDS',
                    style: labelTextStyle.copyWith(fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ActivityLevel.values.length,
                      itemBuilder: (context, index) {
                        final level = ActivityLevel.values[index];
                        return _buildActivityLevelCard(level, calorieNeeds[level]!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLevelCard(ActivityLevel level, String calories) {
    String getActivityText(ActivityLevel level) {
      switch (level) {
        case ActivityLevel.sedentary: return 'Sedentary';
        case ActivityLevel.light: return 'Light Exercise';
        case ActivityLevel.moderate: return 'Moderate Exercise';
        case ActivityLevel.active: return 'Active';
        case ActivityLevel.veryActive: return 'Very Active';
        case ActivityLevel.extraActive: return 'Extra Active';
      }
    }

    String getActivityDescription(ActivityLevel level) {
      switch (level) {
        case ActivityLevel.sedentary: return 'Little or no exercise';
        case ActivityLevel.light: return 'Exercise 1-3 times/week';
        case ActivityLevel.moderate: return 'Exercise 4-5 times/week';
        case ActivityLevel.active: return 'Daily exercise or intense exercise 3-4 times/week';
        case ActivityLevel.veryActive: return 'Intense exercise 6-7 times/week';
        case ActivityLevel.extraActive: return 'Very intense exercise daily, or physical job';
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      color: inactiveCardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getActivityText(level),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    getActivityDescription(level),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '$calories Cal',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}