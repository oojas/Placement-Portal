import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/YoutubeChannels/roadMaps.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class RoadMapAPI {
  static Future<HTTPResponse<List<RoadMaps>>> getRoadMap() async {
    String url = 'https://placement-crack.herokuapp.com/roadMaps';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<RoadMaps> roadmapList = [];
        body.forEach((e) {
          RoadMaps roadMaps = RoadMaps.fromJson(e);
          roadmapList.add(roadMaps);
        });
        return HTTPResponse(true, roadmapList, responseCode: response.statusCode);
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
