// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:apk_spotify_api/service/spotify_service.dart';
import 'package:flutter/material.dart';

class PesquisarArtistaPage extends StatefulWidget {
  final String? access_token;
  const PesquisarArtistaPage({Key? key, this.access_token}) : super(key: key);

  @override
  State<PesquisarArtistaPage> createState() => _PesquisarArtistaPageState();
}

class _PesquisarArtistaPageState extends State<PesquisarArtistaPage> {
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
                labelText: "Pesquise um Artista",
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
                        "Pesquise um artista para começar.",
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
                                  "Erro ao buscar o artista.",
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
    if (snapshot.data["artists"]["items"].isEmpty) {
      return Center(
        child: Text(
          "Nenhum artista encontrado.",
          style: TextStyle(color: const Color.fromARGB(255, 120, 0, 233), fontSize: 16),
        ),
      );
    }
    var artist = snapshot.data["artists"]["items"][0];
    var imageUrl = artist["images"].isNotEmpty ? artist["images"][0]["url"] : null;
    
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: artist["name"],
              labelStyle: TextStyle(color: const Color.fromARGB(255, 120, 0, 233), fontSize: 22.0),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: artist["uri"],
              labelStyle: TextStyle(color: const Color.fromARGB(255, 120, 0, 233), fontSize: 22.0),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ) 
      
    );
  }
}