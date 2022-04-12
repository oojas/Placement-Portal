import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/httpresponse.dart';
import 'package:placementcracker/modals/jobs.dart';

class JobAPI {
  static Future<HTTPResponse<List<Jobs>>> getJobs() async {
    String url = 'http://placement-crack.herokuapp.com/jobs';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Jobs> jobList = [];
        body.forEach((e) {
          Jobs job = Jobs.fromJson(e);
          jobList.add(job);
        });
        return HTTPResponse(true, jobList, responseCode: response.statusCode);
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
