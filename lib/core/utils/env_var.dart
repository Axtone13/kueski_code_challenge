class Env {
  static String get moviesApi => const String.fromEnvironment("TMDB_API");
  static String get bearerToken => const String.fromEnvironment("BEARER_TOKEN");
}
