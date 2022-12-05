abstract class AppNewsStates {}

class AppInitialStates extends AppNewsStates{}

class NewsBottomNavState extends AppNewsStates{}
class AppBottomChangeStats extends AppNewsStates {}

class NewsGetBusinessSuccessState extends AppNewsStates {}
class NewsGetBusinessLoadingState extends AppNewsStates {}
class NewsGetBusinessErrorState extends AppNewsStates {
  final String onError;

  NewsGetBusinessErrorState(this.onError);
}


class NewsGetScienceSuccessState extends AppNewsStates {}
class NewsGetScienceLoadingState extends AppNewsStates {}
class NewsGetScienceErrorState extends AppNewsStates {
  final String onError;

  NewsGetScienceErrorState(this.onError);
}


class NewsGetSportsSuccessState extends AppNewsStates {}
class NewsGetSportsLoadingState extends AppNewsStates {}
class NewsGetSportsErrorState extends AppNewsStates {
  final String onError;

  NewsGetSportsErrorState(this.onError);
}


class NewsGetSearchSuccessState extends AppNewsStates {}
class NewsGetSearchLoadingState extends AppNewsStates {}
class NewsGetSearchErrorState extends AppNewsStates {
  final String onError;

  NewsGetSearchErrorState(this.onError);
}
