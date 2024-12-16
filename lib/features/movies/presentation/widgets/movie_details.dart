import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final String title;
  final String data;

  const MovieDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: data),
        ],
      ),
    );
  }
}
