import 'package:cloud_firestore/cloud_firestore.dart';

class ChatInsertReqDto {
  String from;
  String to;
  String msg;
  Timestamp sendDate;

  ChatInsertReqDto({required this.from, required this.to, required this.msg, required this.sendDate});

  // dart -> map (toJson)
  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "msg": msg,
        "sendData": sendDate,
      };

  // map -> dart (from Json)
  factory ChatInsertReqDto.fromJson(Map<String, dynamic> json) => ChatInsertReqDto(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        sendDate: json["sendDate"],
      );
}
// class ChatDeleteReqDto {}
