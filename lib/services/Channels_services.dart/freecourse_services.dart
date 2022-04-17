import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/YoutubeChannels/FreeCourse.dart';
import 'package:placementcracker/modals/httpresponse.dart';


class FreeCourseAPI {
  static Future<HTTPResponse<List<FreeCourse>>> getCourse() async {
    String url = 'https://crack-placement.herokuapp.com/freeCourses';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<FreeCourse> courseList = [];
        body.forEach((e) {
          FreeCourse course = FreeCourse.fromJson(e);
          courseList.add(course);
        });
        return HTTPResponse(true, courseList, responseCode: response.statusCode);
      } else {
        return HTTPResponse(false, null,
            message: 'Invalid response', responseCode: response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, null, message: 'unable to reach internet');
    } on FormatException {
      return HTTPResponse(false, null,
          message: 'Invalid response recieved from server');
    } catch (e) {
      return HTTPResponse(false, null, message: 'Something went wrong');
    }
  }
}
