import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  String event_name;
  String img_url;
  String body;
  bool enabled;
  EventDescription(
      {Key? key,
      required this.event_name,
      required this.img_url,
      required this.body,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title:Text(event_name,
          style: TextStyle(
            fontFamily: 'CinzelDecorative',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img_url),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20.0)),
              ),
              child: Column(
                children: <Widget>[
                  //SizedBox(height: 10,),
                  enabled == true
                      ? Container(
                          width: 180,
                          margin: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.grey[900],
                            onPressed: () {
                              // showDialog(context: context,builder: (context)=>PUBGpop());
                            },
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 10,
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(body.replaceAll('\\n', '\n'),
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
