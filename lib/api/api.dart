class ApiService{

  static const String BASE_URL='https://api.themoviedb.org/3/movie/';
  static const String BASE_URL_SERIES='https://api.themoviedb.org/3/tv/';
  static const String BASE_URL_SERIESDISCOVER='http://api.themoviedb.org/3/discover/tv';
  static const String BASE_URL_MOVIESDISCOVER='http://api.themoviedb.org/3/discover/movie';
  static const String BASE_URL_MOVIES_SEARCH='http://api.themoviedb.org/3/search/movie';
  static const String API_KEY='?api_key=b8cdc8a029caa73a47ab09762ce5c157';
  static const String MYAPI_KEY='?api_key=b7a0c4efe47ff18c7be56824d6e9972b';
  static const String POPULAR='popular';
  static const String PAGE1='&page=1';
  static const String PAGE2='&page=2';
  static const String PAGE3='&page=3';
  static const String PAGE4='&page=4';
  static const String UPCOMING='upcoming';
  static const String LATEST='latest';
  static const String INTHEATERS='now_playing';
  static const String SERIES="";
  static const String TOP_RATED='top_rated';
  static const String GET_SIMILAR='/similar';
  static const String GET_TRAILER='/videos';

  static const String SORT_BY_POPULARITY='&sort_by=popularity.desc';
  ///we can just pass our prefered size instead of original as w400
  static const String IMAGE_URL='https://image.tmdb.org/t/p/w300/';
  static const String IMAGE_URLBIG='https://image.tmdb.org/t/p/original/';
  static const String GENRE_ACTION='&with_genres=28';
  static const String GENRE_HORROR='&with_genres=27';
  static const String GENRE_ADVENTURE='&with_genres=12';
  static const String GENRE_COMEDY='&with_genres=35';
  static const String GENRE_ANIMATION='&with_genres=16';
  static const String GENRE_CRIME='&with_genres=80';
  static const String GENRE_DOCUMENTRY='&with_genres=99';
  static const String GENRE_DRAMA='&with_genres=18';
  static const String GENRE_FAMILY='&with_genres=10751';
  static const String GENRE_FANTASY='&with_genres=14';
  static const String GENRE_HISTORY='&with_genres=36';
  static const String GENRE_MYSTERY='&with_genres=9648';
  static const String GENRE_ROMANCE='&with_genres=10749';
  static const String GENRE_SCIENCE_FICTION='&with_genres=878';
  static const String GENRE_THRILLER='&with_genres=53';
  static const String GENRE_WAR='&with_genres=10752';
  static const String GENRE_WESTERN='&with_genres=37';

  static const String GENRE_ACTION_ADVEN='&with_genres=10759';
  static const String GENRE_SCI_FI_FANTASY='&with_genres=10765';
  static const String GENRE_WAR_POLITICS='&with_genres=10768';


  static const String MOVIE_CAST='/credits';
  static const String ONAIRSERIES='on_the_air';
  static const String AIRINGTODAYSERIES='airing_today';


}