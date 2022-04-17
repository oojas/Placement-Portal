import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/YoutubeChannels/core_subjects.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class CoreAPI {
  static Future<HTTPResponse<List<Core>>> getCore() async {
    String url = 'https://crack-placement.herokuapp.com/subjects';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Core> coreList = [];
        body.forEach((e) {
          Core core = Core.fromJson(e);
          coreList.add(core);
        });
        return HTTPResponse(true, coreList, responseCode: response.statusCode);
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
