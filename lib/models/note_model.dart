class NoteModel {
  late String title;
  late String text;
  late DateTime dateTime;

  NoteModel({
    required this.title,
    required this.text,
    required this.dateTime
  });

  NoteModel.fromJson(Map<String, dynamic> json){
    title = json["title"] as String;
    text = json["text"] as String;
    dateTime = DateTime.parse(json["dateTime"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "text": text,
      "dateTime": dateTime.toIso8601String()
    };
  }
}