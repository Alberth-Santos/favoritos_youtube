import 'package:app_youtube/blocs/favorite_bloc.dart';
import 'package:app_youtube/blocs/videos_bloc.dart';
import 'package:app_youtube/screens/home.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc((i) => VideosBloc()),
          Bloc((i) => FavoriteBloc()),
        ],
        dependencies: const [],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        ));
  }
}
