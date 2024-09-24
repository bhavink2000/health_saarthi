import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/App%20Helper/font_&_color_helper.dart';

class CommonDropdownSearch extends StatelessWidget {
  final List<String> items;
  final String label;
  final String? selectedItem;
  final bool? isRequiredField;
  final ValueChanged onChanged;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator? validator;
  const CommonDropdownSearch(
      {super.key,
      required this.items,
      required this.label,
      this.isRequiredField = false,
      required this.onChanged,
      required this.selectedItem,
      this.validator,
      this.suffixIcon,
      this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownSearch<String>(
        dropdownButtonProps: suffixIcon != null
            ? DropdownButtonProps(icon: suffixIcon!)
            : const DropdownButtonProps(),
        autoValidateMode: autovalidateMode,
        popupProps: PopupProps.dialog(
            showSelectedItems: true,
            showSearchBox: true,
            fit: FlexFit.loose,
            dialogProps: DialogProps(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            label: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: label, style: const TextStyle(color: Colors.black)),
              if (isRequiredField!)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: FontHelper.montserratRegular,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
            ),
          ),
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
        validator: validator,
      ),
    );
  }
}
