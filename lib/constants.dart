import 'package:flutter/material.dart';

const activeCardColor = Color(0xFF1D1E33);
const inactiveCardColor = Color(0xFF111328);
const bottomContainerHeight = 80.0;
const bottomContainerColor = Color(0xFFEB1555);

enum Gender {
  male,
  female,
}

enum CalculatorType {
  bmi,
  bmr,
}

enum ActivityLevel {
  sedentary,    // Little or no exercise
  light,        // Exercise 1-3 times/week
  moderate,     // Exercise 4-5 times/week
  active,       // Daily exercise or intense exercise 3-4 times/week
  veryActive,   // Intense exercise 6-7 times/week
  extraActive,  // Very intense exercise daily, or physical job
}

// Activity multipliers untuk BMR
const Map<ActivityLevel, double> activityMultipliers = {
  ActivityLevel.sedentary: 1.2,
  ActivityLevel.light: 1.375,
  ActivityLevel.moderate: 1.55,
  ActivityLevel.active: 1.725,
  ActivityLevel.veryActive: 1.9,
  ActivityLevel.extraActive: 2.0,
};

// Activity descriptions
const Map<ActivityLevel, String> activityDescriptions = {
  ActivityLevel.sedentary: 'Little or no exercise',
  ActivityLevel.light: 'Exercise 1-3 times/week',
  ActivityLevel.moderate: 'Exercise 4-5 times/week',
  ActivityLevel.active: 'Daily exercise or intense exercise 3-4 times/week',
  ActivityLevel.veryActive: 'Intense exercise 6-7 times/week',
  ActivityLevel.extraActive: 'Very intense exercise daily, or physical job',
};

const labelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const numberTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
);

const buttonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const resultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const bmiTextStyle = TextStyle(
  fontSize: 100,
  fontWeight: FontWeight.bold,
);

// BMR Specific Styles
const bmrTextStyle = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
);

const activityTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const calorieTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);