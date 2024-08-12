import 'package:bmicalculator/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/HomeScreenProvider.dart';
import 'WeightSelector.dart';
class WeightAndAgeContainer extends StatefulWidget {
  const WeightAndAgeContainer({super.key});

  @override
  State<WeightAndAgeContainer> createState() => _WeightAndAgeContainerState();
}

class _WeightAndAgeContainerState extends State<WeightAndAgeContainer> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return Row(
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
    );
  }
}
