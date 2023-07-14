class MonthReportModel {
  int? status;
  List<MonthData>? monthData;

  MonthReportModel({this.status, this.monthData});

  MonthReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      monthData = <MonthData>[];
      json['data'].forEach((v) {
        monthData!.add(new MonthData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.monthData != null) {
      data['data'] = this.monthData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthData {
  String? month;
  dynamic amount;
  dynamic count;

  MonthData({this.month, this.amount, this.count});

  MonthData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['amount'] = this.amount;
    data['count'] = this.count;
    return data;
  }
}