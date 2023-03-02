import 'package:flutter/material.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/domain/core/di/injectable.dart';
import 'package:netflix_clone/presentation/main_page/widgets/screen_main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DownloadsBloc>(),
        ),
        BlocProvider(
          create: (ctx) => getIt<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FastLaughBloc>(),
        ),
          BlocProvider(
          create: (context) => getIt<HotAndNewBloc>(),
        ),
          BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'NETFLIX CLONE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
        ),
        home: ScreenMainPage(),
      ),
    );
    // );
  }
}
