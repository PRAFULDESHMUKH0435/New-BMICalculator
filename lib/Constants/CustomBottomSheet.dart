import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/DietPlans.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.deepPurpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView( // Added SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust to min to avoid overflow
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your BMI is',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${provider.BMI}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Kg/m²',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${provider.bmicategory}',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Height : ${provider.selectedHeight.toDouble()} Ft | Weight : ${provider.selectedWeight} kilograms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A BMI of ${provider.BMI.toInt()} is in the ${provider.bmicategory} category for your height. '
                  '${provider.BMISuggestions}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DietPlans(BMICategory: provider.bmicategory,)));
                },
                child: Text("Check Out Diet Plans ->",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}
