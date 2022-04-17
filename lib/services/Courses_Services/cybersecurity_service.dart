import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/CyberSecurity.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class CyberAPI {
  static Future<HTTPResponse<List<Cyber>>> getCyber() async {
    String url = 'https://crack-placement.herokuapp.com/cybersecurity';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Cyber> cyberList = [];
        body.forEach((e) {
          Cyber cyber = Cyber.fromJson(e);
          cyberList.add(cyber);
        });
        return HTTPResponse(true, cyberList, responseCode: response.statusCode);
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
