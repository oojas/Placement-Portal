import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/devops.dart';
import 'package:placementcracker/modals/httpresponse.dart';


class DevAPI {
  static Future<HTTPResponse<List<Dev>>> getDev() async {
    String url = 'https://crack-placement.herokuapp.com/devops';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Dev> devList = [];
        body.forEach((e) {
          Dev dev = Dev.fromJson(e);
          devList.add(dev);
        });
        return HTTPResponse(true, devList, responseCode: response.statusCode);
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
