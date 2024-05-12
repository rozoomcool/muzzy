import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glossy/glossy.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/player_bloc/player_cubit.dart';
import '../../domain/player_bloc/player_state.dart';
import '../components/song_progress.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, AppPlayerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: state is NonEmptyPlayerState
              ? GlossyContainer(
                  border: Border.all(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(56),
                  height: 72,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                state.item.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context).hintColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                  onPressed: () {
                                    state is PlayedPlayerState
                                        ? context.read<PlayerCubit>().stop()
                                        : context.read<PlayerCubit>().play();
                                  },
                                  icon: Icon(state is PlayedPlayerState
                                      ? Iconsax.pause
                                      : Iconsax.play)),
                            ],
                          ),
                          SizedBox(
                              width: 196,
                              child: SongProgress(
                                  totalDuration: (state).item.duration ??
                                      const Duration(seconds: 1),
                                  songHandler: context
                                      .watch<PlayerCubit>()
                                      .audioHandler))
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
