// Provider
import 'package:chatting/domain/chat/chat_firestore_repository.dart';
import 'package:chatting/dto/chat/chat_req_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;
  ChatController(this._ref);

  void insert(ChatInsertReqDto dto) async {
    DocumentReference doc = await _ref.read(chatFirestoreRepositoryProvider).insert(dto);
    // insert하고 응답데이터를 받아야하는데 통신했기때문에 데이터를 바로 받을 수 없어서 future로 받거나
    // await async 해서 기다렸다가 future가 아닌 데이터로 받음
    if (doc.id.isEmpty) {
      // insert 실패시 - alertDialog 띄움
    } else {
      // insert 성공시 - 화면 이동
    }
    print("디버그:${doc.snapshots()}");
    print("디버그:${doc.id}");
  }
}
