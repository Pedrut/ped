enum MediaType {
  book,
  movie,
  music,
}

abstract class Media {
  final MediaType type;
  final String title;
  final String name;
  final int duration;

  Media(this.type, this.title, this.name, this.duration);
}

class AudioBook extends Media {
  AudioBook(String title, String author, int duration)
      : super(MediaType.book, title, author, duration);
}

class Movie extends Media {
  Movie(String title, String director, int duration)
      : super(MediaType.movie, title, director, duration);
}

class Music extends Media {
  Music(String title, String artist, int duration)
      : super(MediaType.music, title, artist, duration);
}
