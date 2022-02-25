class ApiService{

  static const String BASE_URL='https://api.themoviedb.org/3/movie/';
  static const String API_KEY='?api_key=b8cdc8a029caa73a47ab09762ce5c157';
  static const String POPULAR='popular';
  static const String UPCOMING='upcoming';
  static const String LATEST='latest';
  static const String INTHEATERS='now_playing';
  static const String SERIES="";
  static const String TOP_RATED='top_rated';
  static const String GET_SIMILAR='{movie_id}/similar';
  static const String GET_TRAILER='{movie_id}/videos';
  ///we can just pass our prefered size instead of original as w400
  static const String IMAGE_URL='https://image.tmdb.org/t/p/w300/';



}