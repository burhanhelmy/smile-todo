class TodoModel {
  String title;
  String startDate;
  String estEndDate;

  TodoModel({this.title, this.startDate, this.estEndDate});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startDate = json['startDate'];
    estEndDate = json['estEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['estEndDate'] = this.estEndDate;
    return data;
  }
}
