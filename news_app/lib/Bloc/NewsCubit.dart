// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Modules/BusinessNews/BusinessScreen.dart';
import '../Modules/SciencesNews/SciencesScreen.dart';
import '../Modules/SportsNews/SportsScreen.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/MySharedPreferences.dart';
import '../shared/network/remote/DioHelper.dart';
import 'NewsStates.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialNewsState());
  int currentIndex = 0;
  static bool isDarkMode = false;
  List<Widget> NewsScreens = [
    const BusinessScreen(),
    const SportsScreen(),
    const SciencesScreen(),
  ];

  static NewsCubit getInstance(context) => BlocProvider.of(context);

  void changeBottomNavBarIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexNewsState());
    if (index == 0 && businessNews.isEmpty) {
      getCategoryNews('business', GetBusinessNewsState());
    } else if (index == 1 && sportsNews.isEmpty) {
      getCategoryNews('sports', GetSportsNewsState());
    } else if (index == 2 && sciencesNews.isEmpty) {
      getCategoryNews('science', GetSciencesNewsState());
    }
  }

  void getCategoryNews(String category, NewsStates state) {
    emit(LoadingNewsState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': category,
      'apiKey': 'a120e3a077b447da84b1e76192554efa',
    }).then((value) {
      if (state is GetBusinessNewsState) {
        businessNews = value.data['articles'];
      } else if (state is GetSportsNewsState) {
        sportsNews = value.data['articles'];
      } else if (state is GetSciencesNewsState) {
        sciencesNews = value.data['articles'];
      }
      emit(state);
    }).catchError((onError) {
      if (kDebugMode) {
        print('MyError=$onError');
      }
    });
  }

  void getAllFilteredNews(String searchKey, NewsStates state) {
    allFilteredNews = [];
    emit(LoadingNewsState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': searchKey,
      'apiKey': 'a120e3a077b447da84b1e76192554efa',
    }).then((value) {
      allFilteredNews = value.data['articles'];
      emit(state);
    }).catchError((onError) {
      if (kDebugMode) {
        print('MyError=$onError');
      }
    });
  }

  void changeAppMode({bool? savedMode}) {
    isDarkMode = !isDarkMode;
    MySharedPreferences.putBoolean(AppModeSharedPrefKey, isDarkMode).then((value) {
      emit(ChangeNewsAppModeState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}
