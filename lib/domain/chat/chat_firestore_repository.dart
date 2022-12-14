// 리턴 : Stream<List<Chat>> - 계속 수신 받을 수 있음
// List<Chat>은 한번 주고 끝나는것import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatting/domain/chat/chat.dart';
import 'package:chatting/dto/chat/chat_req_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatStreamProvider = StreamProvider<List<Chat>>((ref) {
  // 스트림을 파싱해서 리턴
  final db = FirebaseFirestore.instance; // db에 접근
  // stream provier의 목적은 db.collection("chat").snapshots(); 리턴하는것
  // 파싱을 repository에서 끝내려고

  Stream<QuerySnapshot<Map<String, dynamic>>> stream = db.collection("chat").snapshots(); // map타입 스트림 - 사진찍을건데 타입을 모르니까 map 타입
  return stream.map((snapshot) => snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList()); // 파싱
});
// stream 안의 map의 string object의 dynamic 타입을 리턴해주는데 화면에서 파싱하기 힘드니까
// stream 안의 map 타입을 chat 타입으로 바꿔서 화면에서 파싱하지 않아도 되도록 repository 에서 파싱

// Provider - 메모리 띄우기 위해
final chatFirestoreRepositoryProvider = Provider((ref) {
  return ChatFireStoreRepository();
});

class ChatFireStoreRepository {
  // firestore와 통신
  final db = FirebaseFirestore.instance;
  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    // 문서로 돌려받음
    return db.collection("chat").add(dto.toJson());
    // db에 insert
  }
}
