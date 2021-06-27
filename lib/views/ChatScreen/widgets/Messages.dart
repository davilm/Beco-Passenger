import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_passenger/views/ChatScreen/widgets/MessageBubble.dart';

class Messages extends StatefulWidget {
  final String driverUid;
  final String passengerUid;
  final String imageUrl;

  Messages(this.driverUid, this.passengerUid, this.imageUrl, {Key? key})
      : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where("driverUid", isEqualTo: widget.driverUid)
            .where("passengerUid", isEqualTo: widget.passengerUid)
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
              widget.imageUrl,
              chatDocs[index]['createdAt'],
              chatDocs[index]['userId'] == widget.passengerUid,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        },
      ),
    );
  }
}
