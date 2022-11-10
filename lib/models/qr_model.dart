class QRModel {
  String title;
  String description;
  String date;
  String time;
  String url;

  QRModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.url});
  factory QRModel.fromJson(Map<String, dynamic> json) => QRModel(
      title: json["title"],
      description: json["description"],
      date: json["data"],
      time: json["time"],
      url: json["url"]);
}
