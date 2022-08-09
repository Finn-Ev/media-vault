import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumPadField extends StatelessWidget {
  final String label;
  final Icon? icon;
  final Function onTap;
  const NumPadField({this.label = "", this.icon, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(1000),
            color: Colors.grey[900],
          ),
          child: Center(
            child: icon ??
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
          ),
        ),
      ),
    );
  }
}
