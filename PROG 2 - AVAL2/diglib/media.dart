enum MediaType {
  book,
  movie,
  music,
}

abstract class Media {
  final MediaType type;
  final String title;
  final int duration;

  Media(this.type, this.title, this.duration);

  String get name;
}

class AudioBook extends Media {
  final String author;

  AudioBook(String title, int duration, this.author)
      : super(MediaType.book, title, duration);

  @override
  String get name => author;
}

class Movie extends Media {
  final String director;

  Movie(String title, int duration, this.director)
      : super(MediaType.movie, title, duration);

  @override
  String get name => director;
}

class Music extends Media {
  final String artist;

  Music(String title, int duration, this.artist)
      : super(MediaType.music, title, duration);

  @override
  String get name => artist;
}
