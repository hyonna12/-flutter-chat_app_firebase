import 'dart:math';

import 'package:chat_app_firebase/controller/chat_controller.dart';
import 'package:chat_app_firebase/domain/chat/chat_firestore_repository.dart';
import 'package:chat_app_firebase/dto/chat/chat_req_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListView(ref),
      extendBody: ,

      floatingActionButton: FloatingActionButton(
        onPressed: _onPressedSendButton,
        child: getInputWidget();
      ),
    );
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
              subtitle: Text("from : ${chats[index].from}",),
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

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("메세지 목록"),
    );
  }

  void _onPressedSendButton(WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);

      //서버로 보낼 데이터를 담아둔다.
      //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
      ChatInsertReqDto dto = ChatInsertReqDto(from: "ssar", to: "cos", msg: chatController.text, sendDate: Timestamp.now());

      chatController.insert(dto);
  }

  Widget getInputWidget() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)
      ], color: Theme.of(context).bottomAppBarColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
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
            SizedBox(width: 10,),
            RawMaterialButton(
              onPressed: _onPressedSendButton, //전송버튼을 누를때 동작시킬 메소드
              constraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0
              ),
              elevation: 2,
              fillColor: Theme.of(context).colorScheme.primary,
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
