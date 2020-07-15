class TodoModel {
  String title;
  String startDate;
  String estEndDate;
  bool completed;

  TodoModel({this.title, this.startDate, this.estEndDate, this.completed});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startDate = json['startDate'];
    estEndDate = json['estEndDate'];
    estEndDate = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['estEndDate'] = this.estEndDate;
    data['completed'] = this.completed;
    return data;
  }
}
