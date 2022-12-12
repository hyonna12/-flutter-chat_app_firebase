// Provider
import 'package:chat_app_firebase/domain/chat/chat_firestore_repository.dart';
import 'package:chat_app_firebase/dto/chat/chat_req_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;
  ChatController(this._ref);

  void insert(ChatInsertReqDto dto) {
    Future<DocumentReference> futureDoc = _ref.read(chatFirestoreRepositoryProvider).insert(dto);
    // insert하고 응답데이터를 받아야하는데 통신했기때문에 데이터를 바로 받을 수 없어서 future로 받거나
    // await async 해서 기다렸다가 future가 아닌 데이터로 받음

    futureDoc.then(
      (value) {
        print("document id: ${value.id}");
        // 여기서는 화면이동
        // Navigator.pushNamed(context, Routes.login.path);
        // Navigator.popAndPushNamed(context, Routes.login.path); // pop 띄우면서 화면이동
        // Navigator.pop(context); // 현재 화면 빠져나오기
        // Navigator.pushNamedAndRemoveUntil(context, Routes.login.path, (route) => false); //새로운 화면 띄우면서 기존 화면 날리기
      },
    ).onError(
      (error, stackTrace) {
        print("error:${error}");
        // 여기서는 경고창(에러메시지)
      },
    );
  }
}
