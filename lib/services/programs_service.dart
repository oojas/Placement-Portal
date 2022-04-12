import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Programs.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class ProgramAPI {
  static Future<HTTPResponse<List<Program>>> getPrograms() async {
    String url = 'http://placement-crack.herokuapp.com/programs';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Program> programList = [];
        body.forEach((e) {
          Program program = Program.fromJson(e);
          programList.add(program);
        });
        return HTTPResponse(true, programList, responseCode: response.statusCode);
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
