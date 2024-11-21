// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:apk_spotify_api/service/spotify_service.dart';
import 'package:flutter/material.dart';

class PesquisarMusicaPage extends StatefulWidget {
  final String? access_token;
  const PesquisarMusicaPage({Key? key, this.access_token}) : super(key: key);

  @override
  State<PesquisarMusicaPage> createState() => _PesquisarMusicaPageState();
}

class _PesquisarMusicaPageState extends State<PesquisarMusicaPage> {
  String? campo; 
  Future<Map>? futureResultado;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 0, 233),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 60),
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
            TextField(
              decoration: InputDecoration(
                labelText: "Pesquise uma música",
                labelStyle: TextStyle(color: const Color.fromARGB(255, 120, 0, 233)),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                  futureResultado = pesquisarMusicas(widget.access_token, campo);
                });
              },
            ),
            Expanded(
              child: futureResultado == null
                  ? Center(
                      child: Text(
                        "Pesquise uma música para começar.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : FutureBuilder(
                      future: futureResultado,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Erro ao buscar a música.",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            } else {
                              return exibeResultado(context, snapshot);
                            }
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot){
    if (snapshot.data["tracks"]["items"].isEmpty) {
      return Center(
        child: Text(
          "Nenhuma música encontrada.",
          style: TextStyle(color: const Color.fromARGB(255, 120, 0, 233), fontSize: 16),
        ),
      );
    }
    var track = snapshot.data["tracks"]["items"][0];
    var album = track["album"];
    var releaseDate = album["release_date"];
    var name = track["name"];
    var artists = track["artists"]
        .map((artist) => artist["name"])
        .toList()
        .join(", ");
    var imageUrl = album["images"].isNotEmpty ? album["images"][0]["url"] : null;
    
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          Text(
            name,
            style: TextStyle(
              color: const Color.fromARGB(255, 120, 0, 233), fontSize: 28.0, fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5.0),
          if (imageUrl != null)
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0, // Largura da borda
              ),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, 
              width: 200,
              height: 200, 
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Artistas: ",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 120, 0, 233),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: artists,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Lançamento: ",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 120, 0, 233),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: releaseDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ) 
    );
  }
}