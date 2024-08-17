import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/styles.dart';

class DietPlans extends StatelessWidget {
  String BMICategory;
  DietPlans({required this.BMICategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Diet Plans",
          style: AppStyles.titlestyle,
        ),
      ),
      // body: Container(
      //   height: double.infinity,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(image: AssetImage('Assets/Images/diet_plan.jpg'),fit: BoxFit.cover)
      //   ),
      //   child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 20.0),
      //       child: Text("This Is Premium Feature ,Contact Developer For Premium",style: AppStyles.aboutusquestionstyle,)),
      // ),

      body: Stack(
        children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('Assets/Images/diet_plan.jpg'),fit: BoxFit.cover)
          ),
        ),
        Positioned(
            bottom: 55,
            left: 15,
            right: 5,
            child: Text("This Is Premium Feature ,Contact Developer For Premium",style: AppStyles.premiumstyle,))
        ],
      ),
    );
  }
}
