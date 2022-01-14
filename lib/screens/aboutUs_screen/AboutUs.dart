// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:polygon_clipper/polygon_clipper.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
// import 'bottom_wave_clipper.dart';


// class AboutUs extends StatefulWidget {
//   @override
//   _AboutUsState createState() => _AboutUsState();
// }

// class _AboutUsState extends State<AboutUs> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Create and store the VideoPlayerController. The VideoPlayerController
//     // offers several different constructors to play videos from assets, files,
//     // or the internet.
//     _controller = VideoPlayerController.network(
//         // 'https://drive.google.com/file/d/1NDKX1CZvqb13TZUSa6k1c7Reml8H8on3/view?usp=sharing',
//         // 'https://user-images.githubusercontent.com/68653906/119708505-db083300-be79-11eb-9a96-f2d572ce1e0a.mp4',
//         'https://user-images.githubusercontent.com/68653906/120284916-62223480-c2da-11eb-9f76-8b5623c352c4.mp4');
//     _controller.addListener(() {
//       setState(() {});
//     });

//     // Use the controller to loop the video.
//     _controller.setLooping(true);

//     // Initialize the controller and store the Future for later use.
//     _initializeVideoPlayerFuture =
//         _controller.initialize().then((_) => setState(() {}));
//   }

//   @override
//   void dispose() {
//     // Ensure disposing of the VideoPlayerController to free up resources.
//     _controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor('#282c35'),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: HexColor('#0f0f0f'),
//         // elevation: 6,
//         title: Text('About Us'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 150,
//               margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     height: 150,
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                           height: 150,
//                           width: 150,
//                           child: ClipPolygon(
//                             sides: 3,
//                             borderRadius: 4,
//                             rotate: 20,
//                             boxShadows: [
//                               PolygonBoxShadow(
//                                   color: Colors.pink, elevation: 3),
//                               PolygonBoxShadow(
//                                   color: Colors.white, elevation: 3),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 150,
//                           width: 150,
//                           padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                           child: ClipPolygon(
//                             borderRadius: 8,
//                             sides: 3,
//                             boxShadows: [
//                               PolygonBoxShadow(
//                                   color: Colors.pink, elevation: 3),
//                             ],
//                             child: FutureBuilder(
//                               future: _initializeVideoPlayerFuture,
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.done) {
//                                   // If the VideoPlayerController has finished initialization, use
//                                   // the data it provides to limit the aspect ratio of the video.
//                                   return AspectRatio(
//                                     aspectRatio: _controller.value.aspectRatio,

//                                     // Use the VideoPlayer widget to display the video.
//                                     child: VideoPlayer(_controller),
//                                   );
//                                 } else {
//                                   // If the VideoPlayerController is still initializing, show a
//                                   // loading spinner.
//                                   return Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 70,
//                           right: 32,
//                           child: FlatButton(
//                             onPressed: () {
//                               // Wrap the play or pause in a call to `setState`. This ensures the
//                               // correct icon is shown.
//                               setState(() {
//                                 // If the video is playing, pause it.
//                                 if (_controller.value.isPlaying) {
//                                   _controller.pause();
//                                 } else {
//                                   // If the video is paused, play it.
//                                   _controller.play();
//                                 }
//                               });
//                             },
//                             // Display the correct icon depending on the state of the player.
//                             child: Icon(
//                               _controller.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: Colors.pink,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(10, 35, 0, 0),
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     height: 200,
//                     width: 200,
//                     child: RichText(
//                       text: TextSpan(
//                         text: "",
//                         style: TextStyle(color: Colors.purple),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: '''About ''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: '''Us
// ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: '''        ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 14,
//                                 height: 0.7,
//                                 decorationThickness: 5),
//                           ),
//                           TextSpan(
//                             text: '''
                          
//                           ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontSize: 4,
//                                 height: 1),
//                           ),
//                           TextSpan(
//                             text: '''
// In 2017, "The T.I.T.&S. Computer Society" stood on the mark because of the zeal of some techies who did not allow the things to remain as the were going on, they integrated a team and the society came up with a bang.''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                     // height: 200,
//                     width: 230,
//                     child: RichText(
//                       text: TextSpan(
//                         text: "",
//                         style: TextStyle(color: Colors.purple),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: '''Want to improve your technical skills ?''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: ''' Join our society ASAP
//   ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: '''            ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 14,
//                                 height: 0.7,
//                                 decorationThickness: 5),
//                           ),
//                           TextSpan(
//                             text: '''
                            
//                             ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontSize: 4,
//                                 height: 1),
//                           ),
//                           TextSpan(
//                             text: '''
  
// TCS is a small and modest working Technical Society of T.I.T.&S. College comprising of 40-50 members. The society aims at making solutions to real-world problems and also put up interest in conducting various workshops and events in the college. The Society comprises of 3 branches that are strongly connected to its roots currently: Technical Team, Media Team and Meeting Team.''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 100,
//                     height: 150,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset(
//                         'undraw_flutter_dev_wvqj.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               alignment: Alignment.topCenter,
//               height: 40,
//               child: RichText(
//                 text: TextSpan(
//                   text: "",
//                   style: TextStyle(color: Colors.purple),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '''Our ''',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '''Project's
// ''',
//                       style: TextStyle(
//                           color: Colors.pinkAccent,
//                           fontStyle: FontStyle.italic,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14),
//                     ),
//                     TextSpan(
//                       text: '''#Let's Get Technical''',
//                       style: TextStyle(color: Colors.white, fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//               alignment: Alignment.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: <Widget>[
//                         Icon(
//                           Icons.android_rounded,
//                           size: 50,
//                           color: Colors.pinkAccent,
//                         ),
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             text: "",
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: '''TCS APP''',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontStyle: FontStyle.italic,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     height: 1),
//                               ),
//                               TextSpan(
//                                 text: '''
                                
//   #Let's Get Technical''',
//                                 style:
//                                     TextStyle(color: Colors.black, fontSize: 8),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: <Widget>[
//                         Icon(
//                           Icons.web_rounded,
//                           size: 50,
//                           color: Colors.white,
//                         ),
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             text: "",
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: '''TCS Website''',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontStyle: FontStyle.italic,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     height: 1),
//                               ),
//                               TextSpan(
//                                 text: '''
                                
//   #Let's Get Technical''',
//                                 style:
//                                     TextStyle(color: Colors.white, fontSize: 8),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Colors.blue, Colors.pink],
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: <Widget>[
//                         Icon(
//                           Icons.app_registration,
//                           size: 50,
//                           color: Colors.pinkAccent,
//                         ),
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             text: "",
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: '''Attendance System''',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontStyle: FontStyle.italic,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     height: 1),
//                               ),
//                               TextSpan(
//                                 text: '''
                                
//   #Let's Get Technical''',
//                                 style:
//                                     TextStyle(color: Colors.black, fontSize: 8),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Center(
//                     child: SizedBox(
//                       width: 100,
//                       height: 170,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.asset(
//                           'undraw_project_team_lc5a.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                     // height: 200,
//                     width: 230,
//                     child: RichText(
//                       text: TextSpan(
//                         text: "",
//                         style: TextStyle(color: Colors.purple),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text:
//                                 '''We provide our members an opportunity to work upon live projects.''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: ''' Join Us
//   ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14),
//                           ),
//                           TextSpan(
//                             text: '''            ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 14,
//                                 height: 0.7,
//                                 decorationThickness: 5),
//                           ),
//                           TextSpan(
//                             text: '''
                            
//                             ''',
//                             style: TextStyle(
//                                 color: Colors.pinkAccent,
//                                 fontSize: 4,
//                                 height: 1),
//                           ),
//                           TextSpan(
//                             text: '''
  
// The core motive of the society is to potential is its member's personality by emphasizing on the technical as well as interpersonal skills and also other recreational skills like team management, interaction, time management, etc.
// The society aims at making solutions to real-world problems. Also, we make our members placement ready.''',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//               alignment: Alignment.topCenter,
//               // height: 40,
//               child: RichText(
//                 text: TextSpan(
//                   text: "",
//                   style: TextStyle(color: Colors.purple),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '''Our''',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ''' Mentors''',
//                       style: TextStyle(
//                           color: Colors.pinkAccent,
//                           fontStyle: FontStyle.italic,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
//               padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
//               alignment: Alignment.center,
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                       padding: EdgeInsets.fromLTRB(1, 10, 1, 1),
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: <Widget>[
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.pink,
//                             child: CircleAvatar(
//                               radius: 25,
//                               backgroundImage:
//                                   AssetImage("Dr.MukeshKumar(Mentor).jpg"),
//                             ),
//                           ),
//                           RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               text: "",
//                               children: <TextSpan>[
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
//                                   text: '''Dr. Mukesh Kumar
// (H.O.D. CSE)''',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontStyle: FontStyle.italic,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10,
//                                       height: 1),
//                                 ),
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
//                                   text: '''
                                  
// The principles on which this society is built, has Inherent characters with the cause of increasing development skills of each and every student.''',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 8),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       height: 180,
//                       // width: 115,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(12))),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                       padding: EdgeInsets.fromLTRB(1, 10, 1, 1),
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: <Widget>[
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.white,
//                             child: CircleAvatar(
//                               radius: 25,
//                               backgroundImage:
//                                   AssetImage("Ms.ArchanaParmar.jpeg"),
//                             ),
//                           ),
//                           RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               text: "",
//                               children: <TextSpan>[
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
//                                   text: '''Mrs. Archana Singh Parmar
// (Asst. Professor)''',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontStyle: FontStyle.italic,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10,
//                                       height: 1),
//                                 ),
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
// //                                   text: '''
// //
// // Selena Marie Gomez is an American singer, songwriter, actress, and producer.''',
//                                   text: '''
                                  
// My particular contribution to students is to relate their research interests, career goals and ideas to the practical applications.''',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 8),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       height: 180,
//                       // width: 115,
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Colors.blue, Colors.pink],
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(12))),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                       padding: EdgeInsets.fromLTRB(1, 10, 1, 1),
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: <Widget>[
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.pink,
//                             child: CircleAvatar(
//                               radius: 25,
//                               backgroundImage:
//                                   AssetImage("undraw_voice_interface_eckp.png"),
//                             ),
//                           ),
//                           RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               text: "",
//                               children: <TextSpan>[
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
//                                   text: '''Self Learning
// ''',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontStyle: FontStyle.italic,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10,
//                                       height: 1),
//                                 ),
//                                 TextSpan(text: '''

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.black87)),
//                                 TextSpan(
//                                   text: '''
                                  
// To succeed as an engineer, you have to have the habit of learning. Hell, lets go beyond that: you have to have the love of learning.''',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 8),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       height: 180,
//                       // width: 115,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(12))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     height: 250,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: [
//                         Colors.pinkAccent,
//                         Colors.pink,
//                         Colors.pinkAccent
//                       ]),
//                     ),
//                     child: ClipPath(
//                       child: Container(
//                         color: HexColor('#282c35'),
//                       ),
//                       clipper: BottomWaveClipper(),
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     child: Container(
//                         margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                   // width: MediaQuery.of(context).size.width / 4,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Center(
//                                     child: RichText(
//                                       textAlign: TextAlign.left,
//                                       text: TextSpan(
//                                         text: "",
//                                         children: <TextSpan>[
//                                           TextSpan(text: '''
                                          

// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.white)),
//                                           TextSpan(
//                                             text: '''\n\nContact Us\n''',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontStyle: FontStyle.italic,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 26,
//                                               height: 1,
//                                             ),
//                                           ),
//                                           TextSpan(text: '''
                                           
// ''', style: TextStyle(fontSize: 5, height: 0.5, color: Colors.white)),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Center(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   RadiantGradientMask(
//                                     child: IconButton(
//                                       onPressed: () {
//                                         launch(
//                                             'mailto:tcs.tit@gmail.com?subject=');
//                                       },
//                                       icon: Icon(
//                                         FontAwesomeIcons.googlePlus,
//                                         color: Colors.white,
//                                       ),
//                                       iconSize: 45,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   RadiantGradientMask(
//                                     child: IconButton(
//                                       onPressed: () {
//                                         launch('https://www.fb.com/tcstit');
//                                       },
//                                       icon: Icon(
//                                         FontAwesomeIcons.facebook,
//                                         color: Colors.white,
//                                       ),
//                                       iconSize: 45,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   RadiantGradientMask(
//                                     child: IconButton(
//                                       onPressed: () {
//                                         launch(
//                                             'https://www.instagram.com/tcs_society/');
//                                       },
//                                       icon: Icon(
//                                         FontAwesomeIcons.instagram,
//                                         color: Colors.white,
//                                       ),
//                                       iconSize: 45,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   RadiantGradientMask(
//                                     child: IconButton(
//                                       onPressed: () {
//                                         launch(
//                                             'https://www.linkedin.com/company/t-i-t-s-computer-society');
//                                       },
//                                       icon: Icon(
//                                         FontAwesomeIcons.linkedin,
//                                         color: Colors.white,
//                                       ),
//                                       iconSize: 45,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                   Positioned(
//                     top: 42,
//                     right: 25,
//                     child: Container(
//                       child: Row(
//                         children: <Widget>[
//                           Card(
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: 25,
//                               width: 100,
//                               child: TextField(
//                                 decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     hintText: 'Type Here',
//                                     contentPadding:
//                                         EdgeInsets.fromLTRB(10, 0, 0, 17),
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 8,
//                                     )),
//                               ),
//                             ),
//                           ),
//                           Card(
//                             color: Colors.lightBlueAccent,
//                             child: InkWell(
//                               onTap: () {},
//                               splashColor: Colors.black,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: 25,
//                                 width: 50,
//                                 child: Text(
//                                   'Search',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontStyle: FontStyle.italic,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       height: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RadiantGradientMask extends StatelessWidget {
//   const RadiantGradientMask({required this.child});
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (bounds) => RadialGradient(
//         center: Alignment.center,
//         radius: 0.5,
//         colors: [Colors.white, Colors.blue[800] as Color],
//         tileMode: TileMode.mirror,
//       ).createShader(bounds),
//       child: child,
//     );
//   }
// }
