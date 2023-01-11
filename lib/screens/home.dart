import 'package:app_youtube/blocs/favorite_bloc.dart';
import 'package:app_youtube/blocs/videos_bloc.dart';
import 'package:app_youtube/delegates/data_search.dart';
import 'package:app_youtube/models/video.dart';
import 'package:app_youtube/screens/favorites.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.network(
          "https://media0.giphy.com/media/SVTPWzQWPCUKfji4fp/200w.webp?cid=ecf05e47so6xr5frbddocxezzct9q3atb21ha66jujqi9evf&rid=200w.webp&ct=s",
          height: 80,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());

                if (result != null) {
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
                }
              },
              icon: const Icon(Icons.search)),
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data!.length}");
                  } else {
                    //return Text("0");
                    return Container();
                  }
                }),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              icon: const Icon(Icons.star)),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
