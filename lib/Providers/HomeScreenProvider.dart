import 'dart:ffi';
import 'dart:math';

import 'package:bmicalculator/Hive/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreenProvider with ChangeNotifier{



  /// BMI History Items
  List _bmihistoryitems = Hive.box("BMIHistory").values.toList();
  List get bmihistoryitems => _bmihistoryitems;
  set bmihistoryitems(List value) {
    _bmihistoryitems = value;
    notifyListeners();
  }

  /// BMI
  double _BMI = 0.0;
  double get BMI => _BMI;
  set BMI(double value) {
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
  int _selectedHeight =5;
  int get selectedHeight => _selectedHeight;
  set selectedHeight(int value) {
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
    double heightInMeters = selectedHeight * 0.3048;
    List<String> monthNames = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    int temp = DateTime.now().month;
    String month = monthNames[temp];
    // Calculate BMI
    debugPrint("Weight ${WeightInKg}");
    debugPrint("Height ${heightInMeters}");

    double bmi = WeightInKg / pow(heightInMeters,2);
    bmi.toStringAsFixed(1);
    debugPrint("BMI Is ${bmi}");

    // Add BMI TO HiveDatabase
    String date = "${DateTime.now().day}/${month}/${DateTime.now().year}";
    print("Current Date Is ${date}");
    UserData data =UserData(date: date, bmi: bmi);

    if(bmihistoryitems.length>=10){
      bmihistoryitems.removeAt(0);
      bmihistoryitems.add(data);
    }else{
      bmihistoryitems.add(data);
      bmihistoryitems.reversed;
    }

    ///Printing BMI History Items
    debugPrint("BMI History Items Are");
    print(bmihistoryitems);
  }

}