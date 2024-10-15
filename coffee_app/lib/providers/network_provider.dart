import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

abstract class BaseNetworkProviderService {
  Future<String> getApi(String url);
  Future<Uint8List> download(String imageUrl);
}

class NetworkApiService implements BaseNetworkProviderService {
  final timeOut = const Duration(seconds: 30);

  @override
  Future<String> getApi(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri).timeout(timeOut);

      if (response.statusCode == 200) {
        final body = response.body;
        return body;
      } else {
        return Future.error('Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } on SocketException {
      return Future.error('Unable to establish an internet connection. Please check your network settings and try again.');
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Uint8List> download(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Uint8List imageBytes = response.bodyBytes;

        return imageBytes;
      } else {
        return Future.error('Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
