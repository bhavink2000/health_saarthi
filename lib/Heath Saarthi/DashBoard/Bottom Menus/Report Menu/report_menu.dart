//@dart=2.9
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Chart%20Future/chart_future.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Models/Dashboard Model/Reports Model/day_report_model.dart';
import '../../../App Helper/Backend Helper/Models/Dashboard Model/Reports Model/month_report_model.dart';
import '../../../App Helper/Backend Helper/Models/Dashboard Model/Reports Model/yers_report_model.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';



class ReportMenu extends StatefulWidget {
  const ReportMenu({Key key}) : super(key: key);

  @override
  State<ReportMenu> createState() => _ReportMenuState();
}

class _ReportMenuState extends State<ReportMenu> {

  final monthYear = TextEditingController();
  final year = TextEditingController();
  final fromYear = TextEditingController();
  final toYear = TextEditingController();

  TooltipBehavior _tooltipBehavior;
  List<DayData> dayData;
  List<MonthData> monthData;
  List<YearData> yearData;
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      fetchDay('');
    });
    Future.delayed(const Duration(seconds: 2),(){
      fetchMonth('');
    });
    Future.delayed(const Duration(seconds: 3),(){
      fetchYear('','');
    });
  }


  @override
  Widget build(BuildContext context) {
    List<DayDataEntry> dayChartData = [];
    if (dayData != null) {
      dayChartData = dayData.map((entry) {
        return DayDataEntry(
          date: entry.date,
          amount: entry.amount.toString(),
          count: entry.count,
        );
      }).toList();
    }
    List<MonthDataEntry> monthChartData = [];
    if (monthData != null) {
      monthChartData = monthData.map((entry) {
        return MonthDataEntry(
          month: entry.month,
          amount: entry.amount.toString(),
          count: entry.count,
        );
      }).toList();
    }
    List<YearDataEntry> yearChartData = [];
    if (yearData != null) {
      yearChartData = yearData.map((entry) {
        return YearDataEntry(
          month: entry.month,
          amount: entry.amount.toString(),
          count: entry.count,
        );
      }).toList();
    }
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
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState){
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    contentPadding: const EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: MediaQuery.of(context).size.height / 4.9.h,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                            child: TextField(
                                              controller: monthYear,
                                              readOnly: true,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                fillColor: Colors.lightBlueAccent,
                                                labelText: 'Select Month Year',
                                                labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                              ),
                                              onTap: () async {
                                                DateTime pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1999),
                                                    lastDate: DateTime.now()
                                                );
                                                if(pickedDate != null ){
                                                  String formattedDate = DateFormat('yyyy-MM').format(pickedDate);
                                                  setState(() {
                                                    monthYear.text = formattedDate;
                                                  });
                                                }else{

                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    monthYear.clear();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    if(monthYear.text.isEmpty){
                                                      SnackBarMessageShow.warningMSG('Please Select Date', context);
                                                    }
                                                    else{
                                                      fetchDay(monthYear.text);
                                                      monthYear.clear();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      );
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
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(fontSize: 12),
                    maximumLabels: 100,
                    autoScrollingDelta: 4,
                    majorGridLines: const MajorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    labelFormat: '{value}',
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(enablePanning: true,),
                  series: <ColumnSeries<DayDataEntry, String>>[
                    ColumnSeries<DayDataEntry, String>(
                      dataSource: dayChartData,
                      xValueMapper: (DayDataEntry entry, _) => entry.date,
                      yValueMapper: (DayDataEntry entry, _) => double.parse(entry.amount),
                      dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                    ),
                  ],
                  tooltipBehavior: _tooltipBehavior,
                ),
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
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState){
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    contentPadding: const EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: MediaQuery.of(context).size.height / 4.9.h,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                            child: TextField(
                                              controller: year,
                                              readOnly: true,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                fillColor: Colors.lightBlueAccent,
                                                labelText: 'Select Year',
                                                labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                              ),
                                              onTap: () async {
                                                DateTime pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  initialDatePickerMode: DatePickerMode.year
                                                );
                                                if(pickedDate != null ){
                                                  String formattedDate = DateFormat('yyyy').format(pickedDate);
                                                  setState(() {
                                                    year.text = formattedDate;
                                                  });
                                                }else{

                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    year.clear();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    if(year.text.isEmpty){
                                                      SnackBarMessageShow.warningMSG('Please Select Year', context);
                                                    }
                                                    else{
                                                      fetchMonth(year.text);
                                                      year.clear();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      );
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
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(fontSize: 12),
                    maximumLabels: 100,
                    autoScrollingDelta: 4,
                    majorGridLines: const MajorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    labelFormat: '{value}',
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(enablePanning: true,),
                  series: <ColumnSeries<MonthDataEntry, String>>[
                    ColumnSeries<MonthDataEntry, String>(
                      dataSource: monthChartData,
                      xValueMapper: (MonthDataEntry entry, _) => entry.month,
                      yValueMapper: (MonthDataEntry entry, _) => double.parse(entry.amount),
                      dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                    ),
                  ],
                  tooltipBehavior: _tooltipBehavior,
                ),
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
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState){
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    contentPadding: const EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: MediaQuery.of(context).size.height / 3.9.h,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                            child: TextField(
                                              controller: fromYear,
                                              readOnly: true,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                fillColor: Colors.lightBlueAccent,
                                                labelText: 'Select From Year',
                                                labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                              ),
                                              onTap: () async {
                                                DateTime pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                    initialDatePickerMode: DatePickerMode.year
                                                );
                                                if(pickedDate != null ){
                                                  String formattedDate = DateFormat('yyyy').format(pickedDate);
                                                  setState(() {
                                                    fromYear.text = formattedDate;
                                                  });
                                                }else{

                                                }
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                            child: TextField(
                                              controller: toYear,
                                              readOnly: true,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                fillColor: Colors.lightBlueAccent,
                                                labelText: 'Select To Year',
                                                labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                              ),
                                              onTap: () async {
                                                DateTime pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                    initialDatePickerMode: DatePickerMode.year
                                                );
                                                if(pickedDate != null ){
                                                  String formattedDate = DateFormat('yyyy').format(pickedDate);
                                                  setState(() {
                                                    toYear.text = formattedDate;
                                                  });
                                                }else{

                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    fromYear.clear();
                                                    toYear.clear();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                                child: TextButton(
                                                  child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                  onPressed: (){
                                                    if(fromYear.text.isEmpty || toYear.text.isEmpty){
                                                      SnackBarMessageShow.warningMSG('Please Select Year', context);
                                                    }
                                                    else{
                                                      fetchYear(fromYear.text, toYear.text);
                                                      fromYear.clear();
                                                      toYear.clear();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      );
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
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(fontSize: 12),
                    maximumLabels: 100,
                    autoScrollingDelta: 4,
                    majorGridLines: const MajorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      labelFormat: '{value}',
                      majorTickLines: const MajorTickLines(size: 0),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(enablePanning: true,),
                  series: <ColumnSeries<YearDataEntry, String>>[
                    ColumnSeries<YearDataEntry, String>(
                      dataSource: yearChartData,
                      xValueMapper: (YearDataEntry entry, _) => entry.month,
                      yValueMapper: (YearDataEntry entry, _) => double.parse(entry.amount),
                      dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                    ),
                  ],
                  tooltipBehavior: _tooltipBehavior,
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Future<void> fetchDay(var monthYear) async {
    try {
      final value = await ChartFuture().fetchDayData(getAccessToken.access_token,monthYear ?? '');
      setState(() {
        dayData = value.dayData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> fetchMonth(var yearDate) async {
    try {
      final value = await ChartFuture().fetchMonthData(getAccessToken.access_token, yearDate ?? '');
      setState(() {
        monthData = value.monthData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> fetchYear(fromD, toD) async {
    try {
      final value = await ChartFuture().fetchYearData(getAccessToken.access_token, fromD ?? '' , toD ?? '');
      setState(() {
        yearData = value.yearData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }
}

class DayDataEntry {
  final String date;
  dynamic amount;
  dynamic count;

  DayDataEntry({
    this.date,
    this.amount,
    this.count,
  });
}

class MonthDataEntry {
  final String month;
  dynamic amount;
  dynamic count;

  MonthDataEntry({
    this.month,
    this.amount,
    this.count,
  });
}

class YearDataEntry {
  final String month;
  dynamic amount;
  dynamic count;

  YearDataEntry({
    this.month,
    this.amount,
    this.count,
  });
}