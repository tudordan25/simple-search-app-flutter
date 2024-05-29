import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_app/search_event.dart';
import 'package:simple_bloc_app/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(LoadedWords(words: words)) {
    on<SearchWord>(
      (event, emit) {
        List<String> searchedWords = [];
        for (String word in words) {
          if (word.contains(event.word)) {
            searchedWords.add(word);
          }
        }
        emit(LoadedWords(words: searchedWords));
      },
    );
  }

  static List<String> words = [
    'word0',
    'word1',
    'word2',
    'word3',
    'word4',
    'word5',
    'word6',
    'word7',
    'word8',
    'word9',
    'word1word0',
    'word1word1',
    'word1word2',
    'word1word3',
    'word1word4',
    'word1word5',
  ];
}
