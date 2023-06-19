import 'package:flutter/material.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import 'bar_chart_demo.dart';

class ReportMenu extends StatefulWidget {
  const ReportMenu({Key? key}) : super(key: key);

  @override
  State<ReportMenu> createState() => _ReportMenuState();
}

class _ReportMenuState extends State<ReportMenu> {

  String _selectedFilter = 'Date';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.28,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 20,width: 2,color: hsTwo),
                  const SizedBox(width: 5,),
                  Text("Daily Report",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,letterSpacing: 1,fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      _showFilterOptions();
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: const [
                            Text("Filter",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5),),
                            SizedBox(width: 5,),
                            Icon(Icons.filter_alt_rounded)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.07,
                  child: BarChartSample2(type: 'Daily')
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 20,width: 2,color: hsTwo),
                  const SizedBox(width: 5,),
                  Text("Monthly Report",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,letterSpacing: 1,fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      _showFilterOptions();
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: const [
                            Text("Filter",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5),),
                            SizedBox(width: 5,),
                            Icon(Icons.filter_alt_rounded)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.07,
                  child: BarChartSample2(type: 'Month',)
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 20,width: 2,color: hsTwo),
                  const SizedBox(width: 5,),
                  Text("Yearly Report",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,letterSpacing: 1,fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      _showFilterOptions();
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: const [
                            Text("Filter",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5),),
                            SizedBox(width: 5,),
                            Icon(Icons.filter_alt_rounded)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.07,
                  child: BarChartSample2(type: 'Year',)
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text('Date'),
                  onTap: () {
                    _selectFilter('Date');
                  },
                ),
                ListTile(
                  title: Text('Month'),
                  onTap: () {
                    _selectFilter('Month');
                  },
                ),
                ListTile(
                  title: Text('Year'),
                  onTap: () {
                    _selectFilter('Year');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _selectFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    Navigator.of(context).pop();
  }

}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}