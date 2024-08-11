import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/HomeScreenProvider.dart';

class CustomRangeSlider extends StatefulWidget {
  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
          initialItem: (provider.selectedHeight - (2 * 12)) // Start from 2 feet (24 inches)
      ),
      itemExtent: 50.0,
      onSelectedItemChanged: (int index) {
        setState(() {
          provider.selectedHeight = (index + (2 * 12)); // Adjust selected height calculation
        });
      },
      children: List<Widget>.generate(96, (int index) { // 96 options for 2 feet to 10 feet (96 inches total)
        int totalInches = index + (2 * 12);
        int feet = totalInches ~/ 12;
        int inches = totalInches % 12;
        return Center(
          child: Container(
            color: Colors.black12,
            child: Text(
              '${feet}\' ${inches}\ Ft',
              style: TextStyle(
                fontSize: 20,
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}