import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';

class SelectContainer extends StatelessWidget {
  const SelectContainer({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.selectFunction,
  });
  final String label;
  final bool isSelected;
  final void Function(String label) selectFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectFunction(label);
        context.pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.textTheme.displaySmall?.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isSelected)
              const UnconstrainedBox(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ).paddingAll(20),
    );
  }
}
