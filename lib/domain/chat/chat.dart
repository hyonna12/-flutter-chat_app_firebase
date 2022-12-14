import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  String from;
  String to;
  String msg;
  Timestamp sendDate;

  Chat({required this.id, required this.from, required this.to, required this.msg, required this.sendDate});

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "msg": msg,
        "sendDate": sendDate,
      };

  // map -> dart (fromJson)
  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        sendDate: json["sendDate"],
      );
}
