import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class LocationDropdowns extends StatelessWidget {
  final List<String> items;
  final bool loading;
  final String? selectedItem;
  final String label;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const LocationDropdowns({super.key,
    required this.items,
    required this.loading,
    required this.selectedItem,
    required this.label,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.w,
        child: Stack(
          children: [
            Visibility(
              visible: loading,
              child: const Positioned(
                top: 10,
                right: 5,
                child: CircularProgressIndicator(),
              ),
            ),
            DropdownSearch<String>(
              popupProps: const PopupProps.dialog(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              autoValidateMode: AutovalidateMode.onUserInteraction,
              items: items,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(label),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                ),
              ),
              onChanged: onChanged,
              selectedItem: selectedItem,
              validator: validator,
            )
          ],
        ),
      ),
    );
  }
}
