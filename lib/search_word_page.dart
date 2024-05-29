import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_app/search_bloc.dart';
import 'package:simple_bloc_app/search_event.dart';
import 'package:simple_bloc_app/search_state.dart';
import 'package:simple_bloc_app/theme_switcher_bloc.dart';
import 'package:simple_bloc_app/theme_switcher_event.dart';

class SearchWordPage extends StatelessWidget {
  const SearchWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeSwitcherBloc().add(SetInitialTheme());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Search App'),
        actions: [
          BlocBuilder<ThemeSwitcherBloc, ThemeData>(
            builder: (context, state) {
              return CupertinoSwitch(
                value: state == ThemeData.dark(),
                onChanged: (bool val) {
                  context.read<ThemeSwitcherBloc>().add(ThemeSwitching());
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _searchField(context),
          _words(context),
        ],
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.red),
          contentPadding: const EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey, width: 1)),
        ),
        onChanged: (value) {
          context.read<SearchBloc>().add(SearchWord(word: value));
        },
      ),
    );
  }

  Widget _words(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedWords) {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Text(
                state.words[index],
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            itemCount: state.words.length,
          );
        }
        return Container();
      },
    );
  }
}
