import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_app/search_bloc.dart';
import 'package:simple_bloc_app/search_word_page.dart';
import 'package:simple_bloc_app/theme_switcher_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SearchBloc()),
        BlocProvider(create: (BuildContext context) => ThemeSwitcherBloc()),
      ],
      child: BlocBuilder<ThemeSwitcherBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            theme: state,
            home: SearchWordPage(),
          );
        },
      ),
    );
  }
}
