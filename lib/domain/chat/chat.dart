class Chat {
  String id;
  String from;
  String to;
  String msg;

  Chat({required this.id, required this.from, required this.to, required this.msg});

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "msg": msg,
      };

  // map -> dart (fromJson)
  factory Chat.fromJson(Map<String, dynamic> json, {String? id}) => Chat(
        id: id ?? json["id"], // 대체연산자 - null이면 json["id"] 값이 들어감
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
      );
}
