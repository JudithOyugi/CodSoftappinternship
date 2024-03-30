import 'package:flutter/material.dart';

class Optionspage extends StatelessWidget {
  final String option;
  final String? selectedOption; // Selected option
  final ValueChanged<String>? onOptionSelected;

  const Optionspage({super.key, 
    required this.option,
    required this.selectedOption,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 3, color: const Color(0xFF2A438C)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio(
                    value: option,
                    groupValue: selectedOption, // Set groupValue to the selected option
                    onChanged: (val) {
                      if (onOptionSelected != null) {
                        onOptionSelected!(val.toString());
                      }
                    },
                    activeColor: const Color(0xFF2A438C), // Change active color here
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
