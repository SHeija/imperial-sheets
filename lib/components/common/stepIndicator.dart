import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget{
  StepIndicator(this.steps, this.currentSteps, this.selectedColor, this.unselectedColor);
  final int steps, currentSteps;
  final Color selectedColor, unselectedColor;

  @override
  Widget build(BuildContext context) {
    final List<Widget> indicators = [];
    for (var i = 0; i<steps; i++) {
      if (i < currentSteps)
        indicators.add(_Indicator(selectedColor));
      else
        indicators.add(_Indicator(unselectedColor));
    }

    return (
      Row(
        children: indicators
      )
    );
  }
}

class _Indicator extends StatelessWidget{
  _Indicator(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return (
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: SizedBox(
          width: 10,
          height: 10,
          child: Container(
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle
              )
          ),
        )
      )
    );
  }
}