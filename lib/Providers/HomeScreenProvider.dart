import 'dart:math';
import 'package:bmicalculator/Hive/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreenProvider with ChangeNotifier{

  /// BMI History Items
  var box = Hive.box("BMIHistory");
  List _bmihistoryitems = Hive.box("BMIHistory").values.toList();
  List get bmihistoryitems => _bmihistoryitems;
  set bmihistoryitems(List value) {
    _bmihistoryitems = value;
    notifyListeners();
  }



  /// BMI Category
  String _bmicategory="Underweight";
  String get bmicategory => _bmicategory;
  set bmicategory(String value) {
    _bmicategory = value;
    notifyListeners();
  }


  ///BMI Suggestions
  String _BMISuggestions="Eat Healthy Fruits And Increase The Protein And Carbs Intake In Your Daily Diet";
  String get BMISuggestions => _BMISuggestions;
  set BMISuggestions(String value) {
    _BMISuggestions = value;
  }

  /// BMI
  int _BMI = 0;
  int get BMI => _BMI;
  set BMI(int value) {
    _BMI = value;
    notifyListeners();
  }

  ///Gender Selection
  bool _ismale =true;
  bool get ismale => _ismale;
  set ismale(bool value) {
    _ismale = value;
    notifyListeners();
  }


  /// CURRENT SCREEN INDEX
  int _currentscreenidx = 1;
  int get currentscreenidx => _currentscreenidx;
  set currentscreenidx(int value) {
    _currentscreenidx = value;
    notifyListeners();
  }


  /// User Age
  int _userage=20;
  int get userage=>_userage;
  set(int value){
    _userage=value;
    notifyListeners();
  }


  /// User Height
  double _selectedHeight =9.11;
  double get selectedHeight => _selectedHeight;
  set selectedHeight(double value) {
    _selectedHeight = value;
    notifyListeners();
  }

  /// User Weight
  int _selectedWeight =5;
  int get selectedWeight => _selectedWeight;
  set selectedWeight(int value) {
    _selectedWeight = value;
    notifyListeners();
  }

  /// Decrement User Age
  DecrementUserAge(){
    if(userage>0){
      _userage=_userage-1;
      notifyListeners();
    }
  }

  /// Increment User Age
  IncrementUserAge(){
    if(userage<120){
      _userage=_userage+1;
      notifyListeners();
    }
  }


  CalculateUserBMI(BuildContext context){
    double WeightInKg = selectedWeight.toDouble();
    List<String> monthNames = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    int temp = DateTime.now().month;
    String month = monthNames[temp];

    // Calculate BMI
    debugPrint("Gender ${_ismale?"Male":"Female"}");
    debugPrint("Height ${selectedHeight}");
    debugPrint("Weight ${_selectedWeight}");
    debugPrint("Age ${userage}");
    double bmi = WeightInKg / pow(selectedHeight*0.3048,2);
    bmi.toStringAsFixed(1);
    BMI=bmi.toInt();
    GetBMICategory(BMI);
    debugPrint("BMI Is ${BMI.toInt()}");
    debugPrint("BMI Category ${bmicategory}");
    debugPrint("BMI Suggestion ${BMISuggestions}");
    notifyListeners();


    // Add BMI TO HiveDatabase
    String date = "${DateTime.now().day}/${month}/${DateTime.now().year}";
    print("Current Date Is ${date}");
    UserData data =UserData(date: date, bmi: BMI.toDouble());


    if(bmihistoryitems.length>=10){
      bmihistoryitems.removeAt(0);
      bmihistoryitems.add(data);
    }else{
      box.add(data);
      bmihistoryitems.add(data);
      bmihistoryitems.reversed;
      notifyListeners();
    }

    ///Printing BMI History Items
    debugPrint("BMI History Items Are");
    print(bmihistoryitems);
  }

  String GetBMICategory(int bmi){
    // Category	BMI                       (kg/m2)[c]
    // Underweight (Severe thinness)	      < 16.0
    // Underweight (Moderate thinness)	    16.0 – 16.9
    // Underweight (Mild thinness)	        17.0 – 18.4
    // Normal range                       	18.5 – 24.9
    // Overweight (Pre-obese)             	25.0 – 29.9
    // Obese (Class II)                   	35.0 – 39.9
    // Obese (Class III)                   	≥ 40.0

    switch(bmi){
      case>=1 && <18.5:
        bmicategory="Underweight";
        break;

      case>=18.5 && <=24.9:
        bmicategory="Normal";
        break;

      case>=25.0 && <30.0:
        bmicategory="OverWeight";
        break;

      case>=30.0 && <=1000:
        bmicategory="Obese";
        break;
    }
    notifyListeners();
    debugPrint("Category Passes Is ${bmicategory}");
    GetBMISuggestions(bmicategory);
    return bmicategory;
  }


  String GetBMISuggestions(String category){
    switch(category){
      case "Underweight":
        BMISuggestions="Eat Healthy Fruits And Increase The Protein And Carbs Intake In Your Daily Diet";
        break;

      case "Normal":
        BMISuggestions="Your BMI Is Normal Keep It Maintain And Do Follow Your Diet";
        break;

      case "OverWeight":
        BMISuggestions="You Have Slightly Higher BMI Than Normal Just Do Exercise More And Maintain Your Diet";
        break;

      case "Obese":
        BMISuggestions="Choose Healthier Foods And Do More Regular Physical Activities To Reduce The Risks ";
        break;
    }
    notifyListeners();
    return BMISuggestions;
  }

}