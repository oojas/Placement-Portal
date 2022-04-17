import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/cloudcomputing.dart';
import 'package:placementcracker/modals/httpresponse.dart';


class CloudAPI {
  static Future<HTTPResponse<List<CloudComputing>>> getCloud() async {
    String url = 'https://crack-placement.herokuapp.com/cloud';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<CloudComputing> cloudList = [];
        body.forEach((e) {
          CloudComputing cl = CloudComputing.fromJson(e);
        cloudList.add(cl);
        });
        return HTTPResponse(true, cloudList, responseCode: response.statusCode);
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
