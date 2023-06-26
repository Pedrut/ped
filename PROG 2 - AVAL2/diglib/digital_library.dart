import 'dart:convert';
import 'media.dart';


class DigitalLibrary {
  List<Media> _mediaList = [];

  void loadMedia(String fileName) {
    final fileData = _loadFileData(fileName);
    final jsonData = json.decode(fileData);

    for (var item in jsonData) {
      final type = _parseMediaType(item['type']);
      final title = item['title'];
      final duration = item['duration'];

      switch (type) {
        case MediaType.book:
          final author = item['author'];
          final audioBook = AudioBook(title, duration, author);
          _mediaList.add(audioBook);
          break;
        case MediaType.movie:
          final director = item['director'];
          final movie = Movie(title, duration, director);
          _mediaList.add(movie);
          break;
        case MediaType.music:
          final artist = item['artist'];
          final music = Music(title, duration, artist);
          _mediaList.add(music);
          break;
      }
    }
  }

  String _loadFileData(String fileName) {
   
    return '''
      [
        {"type": "book", "title": "Book Title", "duration": 120, "author": "Book Author"},
        {"type": "movie", "title": "Movie Title", "duration": 150, "director": "Movie Director"},
        {"type": "music", "title": "Music Title", "duration": 180, "artist": "Music Artist"}
      ]
    ''';
  }

  MediaType _parseMediaType(String type) {
    switch (type) {
      case 'book':
        return MediaType.book;
      case 'movie':
        return MediaType.movie;
      case 'music':
        return MediaType.music;
      default:
        throw Exception('Invalid media type');
    }
  }

  void listMedia([MediaType? mediaType]) {
    if (mediaType != null) {
      final filteredList = _mediaList.where((media) => media.type == mediaType).toList();
      _printMediaList(filteredList);
    } else {
      _printMediaList(_mediaList);
    }
  }

  void _printMediaList(List<Media> mediaList) {
    for (var media in mediaList) {
      print('${media.type}: ${media.title} (${media.duration} min)');
    }
  }

  int totalMediaDuration([MediaType? mediaType]) {
    if (mediaType != null) {
      final filteredList = _mediaList.where((media) => media.type == mediaType);
      return _calculateTotalDuration(filteredList);
    } else {
      return _calculateTotalDuration(_mediaList);
    }
  }

  int _calculateTotalDuration(Iterable<Media> mediaList) {
    var totalDuration = 0;

    for (var media in mediaList) {
      totalDuration += media.duration;
    }

    return totalDuration;
  }
}
