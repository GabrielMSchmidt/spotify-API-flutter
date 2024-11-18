import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              height: 40,),
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
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const BuscaCepPage()));
              // },
            ),
            
          ],
        ),
      ),
    );
  }
}