import 'package:apk_spotify_api/service/spotify_service.dart';
import 'package:apk_spotify_api/view/pesquisar_artista_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _accessToken;

  @override
  void initState() {
    super.initState();
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    String? token = await requestAcessToken();
    if (token != null) {
      setState(() {
        _accessToken = token;
        print(_accessToken);
      });
    } else {
      print("Erro ao obter o token.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 0, 233),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/spotify_logo_black.png', 
              fit: BoxFit.contain, 
              height: 40,
              ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            GestureDetector(
              child: const Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 50),
                  Icon(Icons.music_note, color: Color.fromARGB(255, 120, 0, 233), size: 70),
                  SizedBox(width: 10),
                  Text("Pesquisar Músicas", style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const PorExtensoPage()));
              // },
            ),
            const SizedBox(height: 30),
            GestureDetector(
              child: const Row(
                children: <Widget>[
                  SizedBox(width: 50),
                  Icon(Icons.headphones, color: Color.fromARGB(255, 120, 0, 233), size: 70),
                  SizedBox(width: 10),
                  Text("Pesquisar Artistas", style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PesquisarArtistaPage(access_token: _accessToken,)));
              },
            ),
          ],
        ),
      ),
    );
  }
}