import 'package:flutter/material.dart';
import 'package:tcs_app_2/widgets/profile.dart';
import 'member_list.dart';
import 'member_controller.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  List<MembersList> members = [];

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    MemberController().getMembersList().then((members) {
      setState(() {
        this.members = members;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        centerTitle: true,
      ),
      body:GridView.builder(
        itemCount: members.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4
        ),
        itemBuilder: (BuildContext,int index){
          return GestureDetector(
            onTap: (){
              showDialog(context: context,builder: (context)=>profile(
                name: members[index].name,
                skill: members[index].skills,
                batch: members[index].batch,
                linkedinurl:members[index].linkedin_url,
                img_url: members[index].img_url,
              ));
            },
            child: Container(
              padding:EdgeInsets.fromLTRB(0,20,0,0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                shadowColor: Colors.red,
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: screenwidth*0.30,
                      height: screenheight*0.15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(members[index].img_url,
                          fit:BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      members[index].name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ), 
      // ListView.builder(
      //   itemCount: members.length,
      //   itemBuilder: (context, index) {
      //     String default_url="https://firebasestorage.googleapis.com/v0/b/tcsflutterapp-2.appspot.com/o/undraw_profile_pic_ic5t.png?alt=media";
      //     return ListTile(
      //       title: Row(
      //         children: <Widget>[
      //           Icon(Icons.person),
      //           Expanded(
      //             child: Text(members[index].name),
      //           )
      //         ],
      //       ),
      //       subtitle: CircleAvatar(
      //         child: ClipOval(
      //           child: Image.network(
      //             members[index].img_url ?? default_url,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         radius: 30,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
