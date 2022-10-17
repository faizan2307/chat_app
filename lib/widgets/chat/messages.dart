import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  // User? loggedInUser;
  // void getCurrentUser() {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     loggedInUser = user;
  //     print(loggedInUser);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.docs;
final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userImage'],
            chatDocs[index]['userId']==user!.uid,
            chatDocs[index]['userName'],
            key: ValueKey(chatDocs[index].reference.id.toString()),
          ),
        );
      },
    );
  }
}
