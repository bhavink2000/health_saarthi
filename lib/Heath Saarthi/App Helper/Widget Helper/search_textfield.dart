import 'package:flutter/material.dart';

import '../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;

  const SearchTextField({super.key,this.onChanged,this.controller,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: hsPrime.withOpacity(0.1),
            border: Border.all(color: hsPrime, width: 0.2),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: InputBorder.none,
              hintText: 'Search for Tests, Package',
              hintStyle: const TextStyle(fontSize: 12, fontFamily: FontType.MontserratRegular),
              suffixIcon: InkWell(
                onTap: onTap,
                child: const Icon(Icons.close),
              ),
              focusColor: hsPrime),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
