import 'dart:developer';

import 'package:chatting/controller/chat_controller.dart';
import 'package:chatting/domain/chat/chat.dart';
import 'package:chatting/domain/chat/chat_firestore_repository.dart';
import 'package:chatting/dto/chat/chat_req_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageListScreen extends ConsumerWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);
    TextEditingController controller = TextEditingController();

    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildListView(ref),
            _getInputWidget(),
          ],
        ));
  }

  Widget _buildListView(WidgetRef ref) {
    final chatStream = ref.watch(chatStreamProvider);
    return chatStream.when(
      data: (chats) {
        if (chats.isNotEmpty) {
          return ListView.separated(
            itemCount: chats.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("msg : ${chats[index].msg}"),
              subtitle: Text("from : ${chats[index].from}"),
            ),
            separatorBuilder: (context, index) => Divider(),
          );
        } else {
          return Center(
            child: Text(
              "채팅 내역 없음",
              style: TextStyle(fontSize: 50),
            ),
          );
        }
      },
      error: (error, stackTrace) => CircularProgressIndicator(),
      loading: () => CircularProgressIndicator(),
    );
  }

  // Stream<List<ChatInsertReqDto>> streamMessages() {
  //   try {
  //     final db = FirebaseFirestore.instance; // db에 접근
  //
  //     //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
  //     Stream<QuerySnapshot<Map<String, dynamic>>> stream = db.collection('chatrooms/e1IX0v2WJ7f6k3W9iCUe/messages').snapshots();
  //
  //     //새낭 스냅샷(Stream)내부의 자료들을 List<ChatInsertReqDto> 로 변환하기 위해 map을 사용하도록 한다.
  //     //참고로 List.map()도 List 안의 element들을 원하는 형태로 변환하여 새로운 List로 반환한다
  //     return stream.map((snapshot) => snapshot.docs.map((e) => Chat.fromJson(doc));
  //
  //         snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  //
  //   } catch (ex) {
  //     //오류 발생 처리
  //     log('error)', error: ex.toString(), stackTrace: StackTrace.current);
  //     return Stream.error(ex.toString());
  //   }
  // }

  void _onPressedSendButton() {
    TextEditingController controller = TextEditingController();
    try {
      //서버로 보낼 데이터를 모델클래스에 담아둔다.
      //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
      ChatInsertReqDto messageModel = ChatInsertReqDto(from: "ssar", to: "cos", content: controller.text, sendDate: Timestamp.now());

      //Firestore 인스턴스 가져오기
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //원하는 collection 주소에 새로운 document를 Map의 형태로 추가하는 모습.
      firestore.collection('chatrooms/e1IX0v2WJ7f6k3W9iCUe/messages').add(messageModel.toJson());
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }

  Widget _getInputWidget() {
    TextEditingController controller = TextEditingController();
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 15),
                  labelText: "내용을 입력하세요..",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            RawMaterialButton(
              onPressed: _onPressedSendButton, //전송버튼을 누를때 동작시킬 메소드
              constraints: BoxConstraints(minWidth: 0, minHeight: 0),
              elevation: 2,
              // fillColor: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("메세지 목록"),
    );
  }
}
