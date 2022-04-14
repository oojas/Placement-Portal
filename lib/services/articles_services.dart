// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:placementcracker/modals/articles.dart';
import 'package:placementcracker/modals/httpresponse.dart';

class ArticleAPI {
  static Future<HTTPResponse<List<Articles>>> getArticles() async {
    String url = 'https://placement-crack.herokuapp.com/articles';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Articles> articleList = [];
        body.forEach((e) {
          Articles article = Articles.fromJson(e);
          articleList.add(article);
        });
        return HTTPResponse(true, articleList, responseCode: response.statusCode);
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