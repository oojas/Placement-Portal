import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/Courses/MachineLearning.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class MachineAPI {
  static Future<HTTPResponse<List<Machine>>> getMachine() async {
    String url = 'https://crack-placement.herokuapp.com/machinelearning';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Machine> machineList = [];
        body.forEach((e) {
          Machine machine = Machine.fromJson(e);
          machineList.add(machine);
        });
        return HTTPResponse(true, machineList, responseCode: response.statusCode);
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
