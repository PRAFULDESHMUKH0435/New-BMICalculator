// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../Providers/HomeScreenProvider.dart';
//
// class WeightSelector extends StatefulWidget {
//   @override
//   _WeightSelectorState createState() => _WeightSelectorState();
// }
//
// class _WeightSelectorState extends State<WeightSelector> {
//   int selectedWeight = 58; // Default selected weight
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<HomeScreenProvider>(context);
//     return  CupertinoPicker(
//       scrollController: FixedExtentScrollController(
//           initialItem: (provider.selectedHeight - (2 * 12)) // Start from 2 feet (24 inches)
//       ),
//       itemExtent: 50.0,
//       onSelectedItemChanged: (int index) {
//         setState(() {
//           provider.selectedHeight = (index + (2 * 12)); // Adjust selected height calculation
//         });
//       },
//       children: List<Widget>.generate(96, (int index) { // 96 options for 2 feet to 10 feet (96 inches total)
//         int totalInches = index + (2 * 12);
//         int feet = totalInches ~/ 12;
//         int inches = totalInches % 12;
//
//         return Center(
//           child: Text(
//             '${feet}\' ${inches}\ Ft',
//             style: TextStyle(
//               fontSize: 20,
//               color: CupertinoColors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/HomeScreenProvider.dart';

class WeightSelector extends StatefulWidget {
  const WeightSelector({super.key});

  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return SizedBox(
      height: 100.0, // Adjust the height as per your design
      child: RotatedBox(
        quarterTurns: 3, // Rotate the ListWheelScrollView for horizontal scrolling
        child: ListWheelScrollView.useDelegate(
          controller: FixedExtentScrollController(
            initialItem: provider.selectedWeight - 1,
          ),
          itemExtent: 50.0, // Adjust the width of each item
          perspective: 0.005, // Increase perspective for more depth
          diameterRatio: 1.5,
          physics: const FixedExtentScrollPhysics(), // Make scrolling feel like CupertinoPicker
          onSelectedItemChanged: (int index) {
            setState(() {
              provider.selectedWeight = index + 1;
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              if (index < 0 || index >= 200) {
                return null; // Limit the range to 200 items (1 kg to 200 kg)
              }
              return Container(
                color: Colors.black12,
                child: RotatedBox(
                  quarterTurns: 1, // Rotate back the text to the original orientation
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        '${index + 1} kg',
                        style: TextStyle(
                          fontSize: provider.selectedWeight == index + 1 ? 22 : 16,
                          color: provider.selectedWeight == index + 1
                              ? CupertinoColors.white
                              : CupertinoColors.systemGrey,
                          fontWeight: provider.selectedWeight == index + 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: 200, // Number of items (1 kg to 200 kg)
          ),
        ),
      ),
    );
  }
}
