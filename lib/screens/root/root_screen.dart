import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glossy/glossy.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muzzy/screens/components/song_progress.dart';
import 'package:muzzy/screens/root/music_list.dart';
import 'package:muzzy/screens/root/player_bar.dart';
import 'package:muzzy/service/uri_to_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/audios_bloc/audio_cubit.dart';
import '../../domain/audios_bloc/audios_state.dart';
import '../../domain/player_bloc/player_cubit.dart';
import '../../domain/player_bloc/player_state.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<FileSystemEntity> songs = [];

  // AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        var playerCubit = context.watch<PlayerCubit>();

        return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.1, 0.6, 0.9],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF853159),
                    Color(0xFF6f3185),
                    Color(0xFF3c5575),
                  ])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                // backgroundColor: Colors.transparent,
                title: const Text("musician"),
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor: Theme.of(context)
                      .colorScheme
                      .background,
                  statusBarColor:
                      Theme.of(context).colorScheme.background,
                )),
            body: Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 86,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Iconsax.direct_send)),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Iconsax.lovely)),

                            IconButton(
                                onPressed: () {}, icon: const Icon(Iconsax.music_playlist)),
                          ],
                        ),
                      ),
                      const MusicList(),
                    ],
                  ),
                ),
                const PlayerBar()
              ],
            ),
          ),
        );
      },
    );
  }
}
