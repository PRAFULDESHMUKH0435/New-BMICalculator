import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bmicalculator/Constants/CustomRangeSlider.dart';
import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:bmicalculator/Constants/styles.dart';
import 'package:bmicalculator/Screens/AboutUsScreen.dart';
import 'package:bmicalculator/Screens/UserHistoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Constants/WeightSelector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFF181822),
      /// APPBAR
      appBar: AppBar(
        backgroundColor: Color(0xFF21232F),
        // backgroundColor: Color(0xFF0540CA),
        centerTitle: true,
        title: Text(
          "BMI Calculator",
          style: AppStyles.titlestyle,
        ),
      ),

      ///BODY
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF181822)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// MALE AND FEMALE ROW
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap:(){
                          provider.ismale=true;
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF717880)),
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            color:provider.ismale?Color(0xFF043FCB) : Color(0xFF2D2D37),
                          ),
                          margin: EdgeInsets.all(12.0),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'Assets/Images/male.png', // Placeholder image URL
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(width: 10), // Spacing between image and text
                              Text(
                                'Male',
                                style: AppStyles.maleandfemaletextstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap:(){
                          provider.ismale=false;
                        },
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.all(12.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF717880)),
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            color: provider.ismale?Color(0xFF2D2D37): Color(0xFF043FCB),
                          ),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'Assets/Images/female.png', // Placeholder image URL
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(width: 10), // Spacing between image and text
                              Text(
                                'Female',
                                style: AppStyles.maleandfemaletextstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              ///Height
              Text(
                "Height",
                style: AppStyles.titlestyle,
              ),
          
              ///Height Row
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF717880)),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  color: Color(0xFF2D2D37),
                ),
                margin: EdgeInsets.all(12.0),
                height: 120,
                child: CustomRangeSlider(),
              ),
          
              ///Weight and Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Weight",
                    style: AppStyles.titlestyle,
                  ),
                  Text(
                    "Age",
                    style: AppStyles.titlestyle,
                  ),
                ],
              ),
          
              ///Weight And Age Container
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF717880)),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        color: Color(0xFF2D2D37),
                      ),
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      child: WeightSelector(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF717880)),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        color: Color(0xFF2D2D37),
                      ),
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: provider.DecrementUserAge,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.zero),
                                      border: Border.all(color: Color(0xFF717880)),
                                      color: Color(0xFF21212B)),
                                  child: Icon(Icons.remove,color: Color(0xFF717880)),
                                ),
                              ),
                              Text(
                                provider.userage.toString(),
                                style: AppStyles.incdecbuttonstyle,
                              ),
                              GestureDetector(
                                onTap: provider.IncrementUserAge,
                                child: Container(
                                   decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.zero),
                                       border: Border.all(color: Color(0xFF717880)),
                                      color: Color(0xFF21212B)),
                                  child: Icon(Icons.add,color: Color(0xFF717880),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10), // Spacing between image and text
                          Text(
                            'Years',
                            style: AppStyles.kilogramandyeartextstyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: AnimatedNotchBottomBar(
        durationInMilliSeconds: 500,
        elevation: 2.0,
        notchColor: Color(0xFF99D9D9),
        color: Color(0xFF0540CA),
          kBottomRadius: 20,
          kIconSize: 30,
          onTap: (newidx) {
            provider.currentscreenidx=newidx;
             if(provider.currentscreenidx==0){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsScreen()));
             }
             else if(provider.currentscreenidx==1){
               provider.CalculateUserBMI(context);
             }else{
               Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHistoryScreen()));
             }
          },
          notchBottomBarController: NotchBottomBarController(
              index: provider.currentscreenidx
          ),
          bottomBarItems: [
            const BottomBarItem(
              inActiveItem: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              activeItem: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
            const BottomBarItem(
              inActiveItem: CircleAvatar(
                backgroundColor: Color(0xFF99D9D9),
                radius: 30,
                child: Text("BMI ",),
              ),
              activeItem: CircleAvatar(
                backgroundColor: Color(0xFF99D9D9),
                radius: 30,
                child: Text("BMI "),
              ),
            ),
            const BottomBarItem(
              inActiveItem: Icon(
                Icons.history,
                color: Colors.grey,
              ),
              activeItem: Icon(
                Icons.history,
                color: Colors.white,
              ),
            )
          ]),
    );
  }
}
