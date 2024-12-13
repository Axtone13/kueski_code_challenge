import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text("Movie title"),
          Image(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/b0obWWCLRVRqRzlSK1LSGtADkLM.jpg")),
          Text("Generos"),
          Text("Overview"),
          Text("Fecha lanzamiento")
        ],
      )),
    );
  }
}
