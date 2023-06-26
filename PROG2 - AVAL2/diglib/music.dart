import 'media.dart';

class Music extends Media {
  final String artist;

  Music(String title, int duration, this.artist)
      : super(MediaType.music, title, artist, duration);

  @override
  String get name => artist;
}
