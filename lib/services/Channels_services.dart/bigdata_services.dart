import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/bigdata.dart';
import 'package:placementcracker/modals/httpresponse.dart';


class DataAPI {
  static Future<HTTPResponse<List<Data>>> getData() async {
    String url = 'https://crack-placement.herokuapp.com/bigdata';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Data> dataList = [];
        body.forEach((e) {
          Data data = Data.fromJson(e);
        dataList.add(data);
        });
        return HTTPResponse(true, dataList, responseCode: response.statusCode);
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
