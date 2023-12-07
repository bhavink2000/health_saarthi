import 'package:flutter/material.dart';

import '../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class GenderSelectionWidget extends StatefulWidget {
  final ValueChanged<String> onGenderSelected;

  const GenderSelectionWidget({Key? key, required this.onGenderSelected}) : super(key: key);

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Row(
        children: [
          buildRadioTile('Female'),
          buildRadioTile('Male'),
          buildRadioTile('Other'),
        ],
      ),
    );
  }

  Widget buildRadioTile(String title) {
    return Flexible(
      fit: FlexFit.loose,
      child: Theme(
        data: Theme.of(context).copyWith(listTileTheme: ListTileThemeData(horizontalTitleGap: 4)),
        child: RadioListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: TextStyle(fontFamily: FontType.MontserratRegular),
          ),
          value: title,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value as String;
              widget.onGenderSelected(selectedGender);
            });
          },
        ),
      ),
    );
  }
}