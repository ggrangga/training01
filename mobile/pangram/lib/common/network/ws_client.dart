import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Bind.toType(MovieClientImpl)
@injectable
abstract class MovieClient extends BaseClient {}

typedef _PendingRequest = Future<Response> Function();

@lazySingleton
@injectable
class MovieClientImpl extends MovieClient {
  final Client _client;

  MovieClientImpl(this._client);

  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    return _handleResponse(() => super.get(url, headers: headers));
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(() =>
        super.post(url, headers: headers, body: body, encoding: encoding));
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(
        () => super.put(url, headers: headers, body: body, encoding: encoding));
  }

  @override
  Future<Response> delete(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(() => super.delete(url, headers: headers));
  }

  Future<Response> _handleResponse(_PendingRequest request) async {
    Response response = await request();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    throw HttpException('error when handling response');
  }
}
