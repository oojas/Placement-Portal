import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/YoutubeChannels/Dsa.dart';
import 'package:placementcracker/modals/httpresponse.dart';


class DSAAPI {
  static Future<HTTPResponse<List<DSA>>> getDSA() async {
    String url = 'https://crack-placement.herokuapp.com/dsaChannels';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<DSA> dsaList = [];
        body.forEach((e) {
          DSA dsa = DSA.fromJson(e);
          dsaList.add(dsa);
        });
        return HTTPResponse(true, dsaList, responseCode: response.statusCode);
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