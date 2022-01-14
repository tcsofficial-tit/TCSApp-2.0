import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'event_description.dart';

class EventList extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  EventList({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title:const Text('Events',
          style: TextStyle(
            fontFamily: 'CinzelDecorative',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EventDescription(
                        event_name: snapshot.data!.docs[index]['event_name'],
                        img_url: snapshot.data!.docs[index]['img_url'],
                        enabled: snapshot.data!.docs[index]['enabled'],
                        body: snapshot.data!.docs[index]['body2'])));
              },
              child: Container(
                  //padding: EdgeInsets.fromLTRB(10,5,10,5),
                  margin: EdgeInsets.all(10),
                  // height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 0,
                          blurRadius: 15.0,
                          offset: Offset(5.0, 5.0))
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 3, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                snapshot.data!.docs[index]['event_name'],
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.docs[index]['body1'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 100,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                                snapshot.data!.docs[index]['img_url'],
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }
}
