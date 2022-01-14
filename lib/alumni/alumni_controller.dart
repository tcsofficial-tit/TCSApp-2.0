import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'alumni_list.dart';


/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class AlumniController {
  
  // Google App Script Web URL.
  static var URL = Uri.parse("https://script.google.com/macros/s/AKfycby8Lnih__6q2zV92CFtEj7ottcnl16EdcJU2cY8sw8-hUnYFAyXTFeXd3cNm9WRh8Q/exec");
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

    Future<List<AlumniList>> getAlumniList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => AlumniList.fromJson(json)).toList();
    });
  }
}