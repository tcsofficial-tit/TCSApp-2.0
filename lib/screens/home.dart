import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs_app_2/alumni/alumni_screen.dart';
import 'package:tcs_app_2/events/events_stream_builder.dart';
import 'package:tcs_app_2/main.dart';
import 'package:tcs_app_2/members/members_screen.dart';
import 'package:tcs_app_2/screens/aboutUs_screen/AboutUs.dart';
import 'package:tcs_app_2/screens/web_view.dart';

class home extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(auth.currentUser!.email ?? ""),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EventBuilder()));
                },
                child: const Text("Events")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MemberListPage()));
                },
                child: const Text("Members")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AlumniListPage()));
                },
                child: const Text("Alumni")),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (BuildContext context) => AboutUs()));
            //     },
            //     child: const Text("About Us")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                          title: "TCS's Website",
                          selectedUrl:
                              "https://tcsofficials.netlify.app/index.html")));
                },
                child: const Text("TCS Website")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                          title: "TCS Test Series",
                          selectedUrl:
                              "https://testonapp.ezexam.in/online-exams")));
                },
                child: const Text("Test Series"))
          ],
        ),
      ),
    );
  }
}
