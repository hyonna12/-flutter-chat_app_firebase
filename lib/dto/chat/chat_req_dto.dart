import 'package:cloud_firestore/cloud_firestore.dart';

class ChatInsertReqDto {
  String content;
  String from;
  String to;
  Timestamp sendDate;

  ChatInsertReqDto({
    required this.content,
    required this.from,
    required this.to,
    Timestamp? sendDate,
  }) : sendDate = sendDate ?? Timestamp(0, 0);

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "content": content,
        "sendDate": sendDate,
      };

  factory ChatInsertReqDto.fromJson({required Map<String, dynamic> json}) {
    return ChatInsertReqDto(
      from: json["from"],
      to: json["to"],
      content: json["content"],
      sendDate: json["sendDate"] ?? Timestamp(0, 0),
    );
  }
}
