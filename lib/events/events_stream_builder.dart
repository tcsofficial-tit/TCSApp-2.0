import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcs_app_2/events/event_list.dart';

class EventBuilder extends StatelessWidget {
  EventBuilder({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Stream<QuerySnapshot> _eventsStream =
      FirebaseFirestore.instance.collection('Events_Data').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const AlertDialog(title: Text("Something Went Wrong"),);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator(radius: 50));
        }
        return EventList(snapshot: snapshot,);
      },
    );
  }
}