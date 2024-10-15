import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

abstract class BaseNetworkProviderService {
  Future<String> getApi(String url, String apiPath);
  Future<Uint8List> download(String imageUrl);
}

class NetworkApiService implements BaseNetworkProviderService {
  final timeOut = const Duration(seconds: 30);

  @override
  Future<String> getApi(String baseUrl, String apiPath) async {
    try {
      final uri = Uri.https(baseUrl, apiPath);
      final response = await http.get(uri).timeout(timeOut);

      if (response.statusCode == 200) {
        final body = response.body;
        return body;
      } else {
        throw 'Error: ${response.statusCode} ${response.reasonPhrase}';
      }
    } on SocketException {
      throw 'Unable to establish an internet connection. Please check your network settings and try again.';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Uint8List> download(String imageUrl) async {
    try {
      final uri = Uri.https(imageUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Uint8List imageBytes = response.bodyBytes;

        return imageBytes;
      } else {
        throw "Download request not successfull";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
