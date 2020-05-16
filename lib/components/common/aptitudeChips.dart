import 'package:flutter/material.dart';

class AptitudeChips extends StatelessWidget {
  AptitudeChips(this.aptitudes);
  final List<String> aptitudes;

  @override
  Widget build(BuildContext context) {
    final bool hasAptitudes = aptitudes.length > 0;
    if (!hasAptitudes) {
      aptitudes.add('general');
    }
    return Wrap(
      runSpacing: 1.0,
      spacing: 8.0,
      children: aptitudes
          .map((a) => Chip(
                label: Text(a),
              ))
          .toList(),
    );
  }
}
