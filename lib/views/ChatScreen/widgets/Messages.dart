import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:beco_passenger/views/ChatScreen/widgets/MessageBubble.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final user = FirebaseAuth.instance.currentUser;

  String driverUid = "pNKw0MEwouc2ajzaXeYd";
  String passengerUid = "JIbVoYwhRGVQs5AaEuOOBDBQU3J2";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where("driverUid", isEqualTo: driverUid)
            .where("passengerUid", isEqualTo: passengerUid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Something went wrong $snapshot.error");
          }

          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) => MessageBubble(
              chatDocs[index]['text'],
              "https://randomuser.me/api/portraits/women/95.jpg",
              chatDocs[index]['createdAt'],
              chatDocs[index]['userId'] == user!.uid,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        },
      ),
    );
  }
}
