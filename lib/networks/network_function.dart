import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rohan_test/widgets/loading_progres_bar.dart';

class NetworkFunctions {
  /// post api call common handler
  static Future<dynamic> postApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
    try {

      /// call api
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Content-Type': "application/json",
          'Accept': "application/json",
        },
      );

      if (response.statusCode >= 100 && response.statusCode <= 199) {
        /// Informational responses (100–199)
        return response;
      } else if (response.statusCode >= 200 && response.statusCode <= 299) {
        /// Successful responses (200–299)
        return response;
      } else if (response.statusCode >= 300 && response.statusCode <= 399) {
        /// Redirects (300–399)

        return response;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        /// Client errors (400–499)
        return response;
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        /// Server errors (500–599)
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint('ERROR:::$e');
    }
  }
}
