// ignore_for_file: file_names

abstract class NewsStates{}
class InitialNewsState extends NewsStates{}
class ChangeBottomNavBarIndexNewsState extends NewsStates{}
class LoadingNewsState extends NewsStates{}
class GetBusinessNewsState extends NewsStates{}
class GetSportsNewsState extends NewsStates{}
class GetSciencesNewsState extends NewsStates{}
class GetAllFilteredNewsState extends NewsStates{}
class ChangeNewsAppModeState extends NewsStates{}