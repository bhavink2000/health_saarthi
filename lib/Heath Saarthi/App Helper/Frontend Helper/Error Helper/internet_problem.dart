import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';

import '../Snack Bar Msg/getx_snackbar_msg.dart';

class InternetProblem extends StatefulWidget {
  const InternetProblem({Key? key}) : super(key: key);

  @override
  State<InternetProblem> createState() => _InternetProblemState();
}

class _InternetProblemState extends State<InternetProblem> {
  @override
  void initState() {
    super.initState();
    GetXSnackBarMsg.getWarningMsg('Internet connection problem');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CenterLoading(),
          Text('Internet connection problem'),
        ],
      ),
    );
  }
}
