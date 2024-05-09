import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sigv4/sigv4.dart';

extension DioExtension on RequestOptions {
  RequestOptions sign(Sigv4Client client, {String? dateTime}) {
    final signed = client.signedHeaders(
      client.canonicalUrl('$baseUrl$path', query: queryParameters),
      method: method,
      query: queryParameters,
      headers: headers,
      body: data != null ? jsonEncode(data) : null,
      dateTime: dateTime
    );

    headers.addAll(signed);
    return this;
  }
}
