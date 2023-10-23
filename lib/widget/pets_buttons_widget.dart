import 'package:flutter/material.dart';

class PetsButtonsWidget extends StatelessWidget {
  final List<String> interests;
  final ValueChanged<String> onSelectedPet;

  const PetsButtonsWidget({
    Key? key,
    required this.interests,
    required this.onSelectedPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).unselectedWidgetColor;
    final allInterest = ['Flutter', 'React', 'Web'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
     physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: background,
        ),
        child: ToggleButtons(
          isSelected: allInterest.map((interest) => interests.contains(interest)).toList(),
          selectedColor: Colors.white,
          color: Colors.white,
          fillColor: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          renderBorder: false,
          children: allInterest.map(buildPet).toList(),
          onPressed: (index) => onSelectedPet(allInterest[index]),
        ),
      ),
    );
  }

  Widget buildPet(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(text),
      );
}
