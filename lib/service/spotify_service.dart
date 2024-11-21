// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;

final String _token = "15491|ppB1usJvq70fMVZg2O7oEPbGNpGxcqZH";

Future<String?> requestAcessToken() async{
  const String authUrl = "https://accounts.spotify.com/api/token";
  final String basicAuth = base64Encode(utf8.encode('4a383b55a6ae4469a5ba946d3036f720:b3f55c948aa24e31aff55867a45e1b9d'));

  try {
    final response = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['access_token'];
    } else {
      print("Erro ao obter token: ${response.statusCode}, ${response.body}");
      return null;
    }
  } catch (e) {
    print("Erro: $e");
    return null;
  }
}

Future<Map> pesquisarMusicas(String? access_token) async{
  http.Response response;
  response = await http.get(Uri.
  parse("https://api.spotify.com/v1/search?q=Leall&type=artist&market=BR&limit=10"), headers: {'Authorization': 'Bearer $access_token'});
  print(json.decode(response.body));
  return json.decode(response.body);
}

