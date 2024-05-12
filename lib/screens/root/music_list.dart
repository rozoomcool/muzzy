import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glossy/glossy.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muzzy/domain/audios_bloc/audio_cubit.dart';

import '../../domain/audios_bloc/audios_state.dart';
import '../../domain/player_bloc/player_cubit.dart';
import '../../service/uri_to_file.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(builder: (context, state) {
      return state is LoadedAudioState
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: GlossyContainer(
                  border: Border.all(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(18),
                  width: double.infinity,
                  height: 72,
                  child: ListTile(
                    onTap: () {
                      context
                          .read<PlayerCubit>()
                          .playAudioSource(state.songs[index]);
                    },
                    leading: FutureBuilder(
                      future: uriToFile(state.songs[index].artUri),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SizedBox(
                            width: 48,
                            height: 48,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                )),
                          );
                        } else {
                          return SizedBox(
                            width: 48,
                            height: 48,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    title: Text(
                      state.songs[index].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(state.songs[index].artist.toString(), overflow: TextOverflow.ellipsis,),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const RotationTransition(
                            turns: AlwaysStoppedAnimation(90 / 360),
                            child: Icon(Iconsax.more))),
                  ),
                ),
              ),
              itemCount: state.songs.length,
              // separatorBuilder: (BuildContext context, int index) {
              //   return const Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 32.0),
              //     child: Divider(color: Color(0x09FFFFFF)),
              //   );
              // },
            )
          : Container();
    });
  }
}
