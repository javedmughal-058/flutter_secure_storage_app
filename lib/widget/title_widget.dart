import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 50),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
