import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi/components/custom_card.dart';
import 'package:bmi/components/icon_card.dart';
import 'package:bmi/constants.dart';
import 'result_page.dart';
import 'bmr_result_page.dart';
import 'package:bmi/components/round_icon_button.dart';
import 'package:bmi/calculator.dart';
import 'package:bmi/bmr_calculator.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.male;
  int height = 160;
  int weight = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FITNESS CALCULATOR'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gender Selection - Shared by both calculators
            _buildGenderSelection(),
            
            // BMI Calculator Section
            _buildBMISection(),
            
            // BMR Calculator Section  
            _buildBMRSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GENDER',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: Color(0xFF8D8E98),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  color: selectedGender == Gender.male
                      ? activeCardColor
                      : inactiveCardColor,
                  cardChild: IconCard(
                    cardIcon: FontAwesomeIcons.mars,
                    caption: 'MALE',
                  ),
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomCard(
                  color: selectedGender == Gender.female
                      ? activeCardColor
                      : inactiveCardColor,
                  cardChild: IconCard(
                    cardIcon: FontAwesomeIcons.venus,
                    caption: 'FEMALE',
                  ),
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBMISection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.monitor_weight, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'BMI CALCULATOR',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Height
          CustomCard(
            color: activeCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEIGHT',
                  style: labelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: numberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: labelTextStyle,
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    onChanged: (double value) {
                      setState(() {
                        height = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Weight
          CustomCard(
            color: activeCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WEIGHT',
                  style: labelTextStyle,
                ),
                Text(
                  weight.toString(),
                  style: numberTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundIconButton(
                      icon: FontAwesomeIcons.minus,
                      onPressed: () {
                        setState(() {
                          if (weight >= 30) {
                            weight--;
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    RoundIconButton(
                      icon: FontAwesomeIcons.plus,
                      onPressed: () {
                        setState(() {
                          weight++;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          // Calculate BMI Button
          Container(
            height: bottomContainerHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bottomContainerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Calculator cal = Calculator(
                  height: height, 
                  weight: weight, 
                  gender: selectedGender
                );
                String bmi = cal.calculateBMI();
                String result = cal.getResult();
                String information = cal.getInterpretation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      result: result,
                      bmi: bmi,
                      information: information,
                    ),
                  ),
                );
              },
              child: Text(
                'CALCULATE BMI',
                style: buttonTextStyle,
              ),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildBMRSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0A0E21),
        border: Border(
          top: BorderSide(color: Colors.white24, width: 2.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'BMR CALCULATOR',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Age (required for BMR calculation)',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8D8E98),
            ),
          ),
          SizedBox(height: 10),
          // Age Input
          CustomCard(
            color: activeCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AGE',
                  style: labelTextStyle,
                ),
                Text(
                  age.toString(),
                  style: numberTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundIconButton(
                      icon: FontAwesomeIcons.minus,
                      onPressed: () {
                        setState(() {
                          if (age >= 15) {
                            age--;
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    RoundIconButton(
                      icon: FontAwesomeIcons.plus,
                      onPressed: () {
                        setState(() {
                          if (age <= 79) {
                            age++;
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          // BMR Info Card
          CustomCard(
            color: Color(0xFF1A1C2E),
            cardChild: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'About BMR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                    SizedBox(height: 8),
                  Text(
                    'Basal Metabolic Rate (BMR) is the number of calories your body needs to maintain basic functions at rest.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Calculate BMR Button
          Container(
            height: bottomContainerHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2A9D8F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                BMRCalculator bmrCal = BMRCalculator(
                  age: age,
                  gender: selectedGender,
                  height: height,
                  weight: weight,
                );
                String bmr = bmrCal.calculateBMR();
                Map<ActivityLevel, String> calorieNeeds = bmrCal.getAllCalorieNeeds();
                String description = bmrCal.getBMRDescription();
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMRResultPage(
                      bmr: bmr,
                      calorieNeeds: calorieNeeds,
                      description: description,
                    ),
                  ),
                );
              },
              child: Text(
                'CALCULATE BMR',
                style: buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}