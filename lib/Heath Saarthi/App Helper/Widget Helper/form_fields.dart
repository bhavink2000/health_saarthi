import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String mandatoryIcon;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const FormTextField({super.key,
    required this.controller,
    required this.label,
    required this.mandatoryIcon,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    required this.readOnly,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        readOnly: readOnly,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
            borderRadius: BorderRadius.circular(15),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              Text(mandatoryIcon,style: TextStyle(color: Colors.red))
            ],
          ),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.black, size: 20),
        ),
      ),
    );
  }
}
