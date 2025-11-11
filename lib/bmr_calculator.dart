import 'constants.dart';

class BMRCalculator {
  BMRCalculator({
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
  });

  final int age;
  final Gender gender;
  final int height;
  final int weight;

  double _calculateBMRValue() {
    if (gender == Gender.male) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  String calculateBMR() {
    final double bmrValue = _calculateBMRValue();
    return bmrValue.round().toString();
  }

  String getCalorieNeeds(ActivityLevel activityLevel) {
    final double bmrValue = _calculateBMRValue();
    final double multiplier = activityMultipliers[activityLevel] ?? 1.2;
    final double calorieNeeds = bmrValue * multiplier;
    return calorieNeeds.round().toString();
  }

  String getBMRDescription() {
    return 'Basal Metabolic Rate (BMR) is the number of calories your body needs to accomplish its most basic (basal) life-sustaining functions.';
  }

  Map<ActivityLevel, String> getAllCalorieNeeds() {
    final Map<ActivityLevel, String> needs = {};
    for (final ActivityLevel level in ActivityLevel.values) {
      needs[level] = getCalorieNeeds(level);
    }
    return needs;
  }
}