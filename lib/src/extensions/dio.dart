import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sigv4/sigv4.dart';

extension DioExtension on RequestOptions {
  RequestOptions sign(Sigv4Client client) {
    final signed = client.signedHeaders(
      client.canonicalUrl('$baseUrl$path', query: queryParameters),
      method: method,
      query: queryParameters,
      headers: headers,
      body: data != null ? jsonEncode(data) : null,
    );

    headers.addAll(signed);
    return this;
  }
}
