import 'media.dart';

class Movie extends Media {
  final String director;

  Movie(String title, int duration, this.director)
      : super(MediaType.movie, title, director, duration);

  @override
  String get name => director;
}
