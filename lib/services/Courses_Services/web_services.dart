import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/web_app.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class WebAPI {
  static Future<HTTPResponse<List<Web>>> getWeb() async {
    String url = 'https://crack-placement.herokuapp.com/webdev';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Web> webList = [];
        body.forEach((e) {
          Web web = Web.fromJson(e);
          webList.add(web);
        });
        return HTTPResponse(true, webList, responseCode: response.statusCode);
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
