import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

class CommonDropdown extends StatelessWidget {
  final String? selectedValue;
  final String? label;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<String>> items;
  final FormFieldValidator? validator;
  final bool? isRequiredField;
  final AutovalidateMode? autovalidateMode;
  const CommonDropdown(
      {super.key,
      required this.selectedValue,
      this.label,
      required this.onChanged,
      required this.items,
      this.validator,
      this.isRequiredField = false,
      this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        autovalidateMode: autovalidateMode,
        style: const TextStyle(fontSize: 12, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
          ),
          // hintText: labelText,
          label: RichText(
              text: TextSpan(children: [
            TextSpan(text: label, style: const TextStyle(color: Colors.black)),
            if (isRequiredField!)
              const TextSpan(text: ' *', style: TextStyle(color: Colors.red))
          ])),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: FontType.MontserratRegular,
            fontSize: 14,
          ),
        ),
        onChanged: onChanged,
        items: items,
        validator: validator,
      ),
    );
  }
}
