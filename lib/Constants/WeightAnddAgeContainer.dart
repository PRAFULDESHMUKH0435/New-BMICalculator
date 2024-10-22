import 'package:bmicalculator/Constants/AgeSelector.dart';
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
              border: Border.all(color: const Color(0xFF717880)),
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              color: const Color(0xFF2D2D37),
            ),
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(8.0),
            child: const WeightSelector(),
          ),
        ),
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF717880)),
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              color: const Color(0xFF2D2D37),
            ),
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(8.0),
            child: const AgeSelector(),
          ),
        ),
      ],
    );
  }
}
