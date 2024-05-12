import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzy/domain/audios_bloc/audio_cubit.dart';
import 'package:muzzy/domain/player_bloc/player_cubit.dart';
import 'package:muzzy/router/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AudioCubit()..init()),
        BlocProvider(create: (context) => PlayerCubit())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: const ColorScheme.dark(primary: Colors.pink, brightness: Brightness.dark),
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
