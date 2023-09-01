// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/snackbar_msg_show.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';

import '../Snack Bar Msg/getx_snackbar_msg.dart';


class CustomPaginationWidget extends StatefulWidget {
  final int currentPage;
  final int lastPage;
  final Function(int) onPageChange;

  const CustomPaginationWidget({
    Key? key,
    required this.currentPage,
    required this.lastPage,
    required this.onPageChange,
  }) : super(key: key);

  @override
  _CustomPaginationWidgetState createState() => _CustomPaginationWidgetState();
}

class _CustomPaginationWidgetState extends State<CustomPaginationWidget> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 16,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                currentPage--;
              });
              if (currentPage < 0) {
                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().firstPage}');
                currentPage = 0;
              } else {
                widget.onPageChange(currentPage + 1);
              }
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
              child: Icon(Icons.arrow_back, color: Color(0xff0052D4)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              addSemanticIndexes: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(2),
              itemCount: widget.lastPage,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentPage = index;
                    });
                    widget.onPageChange(currentPage + 1);
                  },
                  child: Card(
                    elevation: currentPage == index ? 10 : 5,
                    shadowColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: currentPage == index ? hsOne : Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            color: currentPage == index ? Colors.white : hsOne),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                currentPage++;
              });
              if (currentPage >= widget.lastPage) {
                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().lastPage}');
                currentPage = widget.lastPage - 1;
              } else {
                widget.onPageChange(currentPage + 1);
              }
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Icon(Icons.arrow_forward, color: Color(0xff0052D4)),
            ),
          ),
        ],
      ),
    );
  }
}