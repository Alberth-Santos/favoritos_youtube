import 'package:app_youtube/blocs/favorite_bloc.dart';
import 'package:app_youtube/models/video.dart';
import 'package:app_youtube/screens/video_player.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoPlayer(
                              video: v,
                            )));
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb ?? ""),
                      ),
                      Expanded(
                        child: Text(
                          v.title ?? "",
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
