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
          final audioBook = AudioBook(title, author, duration);
          _mediaList.add(audioBook);
          break;
        case MediaType.movie:
          final director = item['director'];
          final movie = Movie(title, director, duration);
          _mediaList.add(movie);
          break;
        case MediaType.music:
          final artist = item['artist'];
          final music = Music(title, artist, duration);
          _mediaList.add(music);
          break;
      }
    }
  }

  String _loadFileData(String fileName) {
    return '''
      [
        {"type": "book", "title": "Dom Quixote", "duration": 2157, "author": "Miguel de Cervantes"},
        {"type": "book", "title": "Orgulho e Preconceito", "duration": 1080, "author": "Jane Austen"},
        {"type": "book", "title": "Moby Dick", "duration": 1462, "author": "Herman Melville"},
        {"type": "book", "title": "Crime e Castigo", "duration": 1677, "author": "Fiódor Dostoiévski"},
        {"type": "book", "title": "O Morro dos Ventos Uivantes", "duration": 1040, "author": "Emily Brontë"},
        {"type": "book", "title": "O Processo", "duration": 840, "author": "Franz Kafka"},
        {"type": "book", "title": "As Vinhas da Ira", "duration": 1160, "author": "John Steinbeck"},
        {"type": "book", "title": "O Retrato de Dorian Gray", "duration": 680, "author": "Oscar Wilde"},
        {"type": "book", "title": "Os Miseráveis", "duration": 3750, "author": "Victor Hugo"},
        {"type": "book", "title": "A Odisséia", "duration": 1400, "author": "Homero"},
        {"type": "movie", "title": "Cidadão Kane", "duration": 119, "director": "Orson Welles"},
        {"type": "movie", "title": "Casablanca", "duration": 102, "director": "Michael Curtiz"},
        {"type": "movie", "title": "O Poderoso Chefão", "duration": 175, "director": "Francis Ford Coppola"},
        {"type": "movie", "title": "Laranja Mecânica", "duration": 136, "director": "Stanley Kubrick"},
        {"type": "movie", "title": "Lawrence da Arábia", "duration": 216, "director": "David Lean"},
        {"type": "movie", "title": "2001: Uma Odisseia no Espaço", "duration": 149, "director": "Stanley Kubrick"},
        {"type": "movie", "title": "Psicose", "duration": 109, "director": "Alfred Hitchcock"},
        {"type": "movie", "title": "O Iluminado", "duration": 146, "director": "Stanley Kubrick"},
        {"type": "movie", "title": "O Senhor dos Anéis", "duration": 201, "director": "Peter Jackson"},
        {"type": "movie", "title": "Cães de Aluguel", "duration": 99, "director": "Quentin Tarantino"},
        {"type": "movie", "title": "Pulp Fiction", "duration": 154, "director": "Quentin Tarantino"},
        {"type": "movie", "title": "Apocalypse Now", "duration": 153, "director": "Francis Ford Coppola"},
        {"type": "music", "title": "Like a Rolling Stone", "duration": 6, "artist": "Bob Dylan"},
        {"type": "music", "title": "Bohemian Rhapsody", "duration": 5, "artist": "Queen"},
        {"type": "music", "title": "Smells Like Teen Spirit", "duration": 5, "artist": "Nirvana"},
        {"type": "music", "title": "Imagine", "duration": 3, "artist": "John Lennon"},
        {"type": "music", "title": "Sweet Child o' Mine", "duration": 5, "artist": "Guns N' Roses"},
        {"type": "music", "title": "Like a Prayer", "duration": 5, "artist": "Madonna"},
        {"type": "music", "title": "Thriller", "duration": 5, "artist": "Michael Jackson"},
        {"type": "music", "title": "Every Breath You Take", "duration": 4, "artist": "The Police"},
        {"type": "music", "title": "I Want to Hold Your Hand", "duration": 2, "artist": "The Beatles"},
        {"type": "music", "title": "Let It Be", "duration": 4, "artist": "The Beatles"}
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
        throw Exception('Invalid media type: $type');
    }
  }

  int totalMediaDuration([MediaType? mediaType]) {
    final filteredMediaList = _filterMediaList(mediaType);
    return _calculateTotalDuration(filteredMediaList);
  }

  List<Media> _filterMediaList(MediaType? mediaType) {
    if (mediaType != null) {
      return _mediaList.where((media) => media.type == mediaType).toList();
    }
    return _mediaList;
  }

  int _calculateTotalDuration(List<Media> mediaList) {
    int totalDuration = 0;
    for (var media in mediaList) {
      totalDuration += media.duration;
    }
    return totalDuration;
  }

  void listMedia([MediaType? mediaType]) {
    final filteredMediaList = _filterMediaList(mediaType);

    for (var media in filteredMediaList) {
      String mediaTypeString = _parseMediaTypeString(media.type);
      print('${mediaTypeString.padRight(6)} ${media.title.padRight(30)} ${media.name.padRight(30)} ${media.duration}');
    }
  }

  String _parseMediaTypeString(MediaType mediaType) {
    switch (mediaType) {
      case MediaType.book:
        return 'livro';
      case MediaType.movie:
        return 'filme';
      case MediaType.music:
        return 'música';
    }
  }
}
