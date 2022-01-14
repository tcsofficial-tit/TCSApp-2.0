import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'member_list.dart';


/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class MemberController {
  
  // Google App Script Web URL.
  static var URL = Uri.parse("https://script.google.com/macros/s/AKfycbwdivafWQ8DvyH6EJr7L4eAw9zpAtE7ZBgaCWHgLCHvNz_2z-xESgKpuNA9ObR6blgdtw/exec");
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

    Future<List<MembersList>> getMembersList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => MembersList.fromJson(json)).toList();
    });
  }
}