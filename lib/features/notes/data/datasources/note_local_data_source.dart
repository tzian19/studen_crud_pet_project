import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/note_model.dart';
import '../../../../core/error/failures.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getCachedNotes();
  Future<List<NoteModel>> getCachedMusicNotes();
  Future<List<NoteModel>> getCachedTextNotes();
  Future<void> cacheNotes(List<NoteModel> notes);
  Future<void> cacheMusicNotes(List<NoteModel> musicNotes);
  Future<void> cacheTextNotes(List<NoteModel> textNotes);
  Future<void> addNote(NoteModel note, String category);
  Future<void> updateNote(NoteModel note, String category);
  Future<void> deleteNote(String noteId, String category);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  static const String NOTES_KEY = 'notes';
  static const String MUSIC_NOTES_KEY = 'musicNotes';
  static const String TEXT_NOTES_KEY = 'textNotes';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _notesFile async {
    final path = await _localPath;
    return File('$path/notes.json');
  }

  Future<Map<String, dynamic>> _readData() async {
    try {
      final file = await _notesFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return json.decode(contents) as Map<String, dynamic>;
      }
      return {
        NOTES_KEY: <Map<String, dynamic>>[],
        MUSIC_NOTES_KEY: <Map<String, dynamic>>[],
        TEXT_NOTES_KEY: <Map<String, dynamic>>[],
      };
    } catch (e) {
      throw CacheFailure();
    }
  }

  Future<void> _writeData(Map<String, dynamic> data) async {
    try {
      final file = await _notesFile;
      await file.writeAsString(json.encode(data));
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<List<NoteModel>> getCachedNotes() async {
    final data = await _readData();
    final notesList = data[NOTES_KEY] as List<dynamic>? ?? [];
    return notesList.map((json) => NoteModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<NoteModel>> getCachedMusicNotes() async {
    final data = await _readData();
    final notesList = data[MUSIC_NOTES_KEY] as List<dynamic>? ?? [];
    return notesList.map((json) => NoteModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<NoteModel>> getCachedTextNotes() async {
    final data = await _readData();
    final notesList = data[TEXT_NOTES_KEY] as List<dynamic>? ?? [];
    return notesList.map((json) => NoteModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> cacheNotes(List<NoteModel> notes) async {
    final data = await _readData();
    data[NOTES_KEY] = notes.map((note) => note.toJson()).toList();
    await _writeData(data);
  }

  @override
  Future<void> cacheMusicNotes(List<NoteModel> musicNotes) async {
    final data = await _readData();
    data[MUSIC_NOTES_KEY] = musicNotes.map((note) => note.toJson()).toList();
    await _writeData(data);
  }

  @override
  Future<void> cacheTextNotes(List<NoteModel> textNotes) async {
    final data = await _readData();
    data[TEXT_NOTES_KEY] = textNotes.map((note) => note.toJson()).toList();
    await _writeData(data);
  }

  @override
  Future<void> addNote(NoteModel note, String category) async {
    final data = await _readData();
    final key = _getCategoryKey(category);
    final notesList = List<Map<String, dynamic>>.from(data[key] ?? []);
    notesList.add(note.toJson());
    data[key] = notesList;
    await _writeData(data);
  }

  @override
  Future<void> updateNote(NoteModel note, String category) async {
    final data = await _readData();
    final key = _getCategoryKey(category);
    final notesList = List<Map<String, dynamic>>.from(data[key] ?? []);
    final index = notesList.indexWhere((n) => n['id'] == note.id);
    if (index != -1) {
      notesList[index] = note.toJson();
      data[key] = notesList;
      await _writeData(data);
    }
  }

  @override
  Future<void> deleteNote(String noteId, String category) async {
    final data = await _readData();
    final key = _getCategoryKey(category);
    final notesList = List<Map<String, dynamic>>.from(data[key] ?? []);
    notesList.removeWhere((n) => n['id'] == noteId);
    data[key] = notesList;
    await _writeData(data);
  }

  String _getCategoryKey(String category) {
    switch (category.toLowerCase()) {
      case 'music':
        return MUSIC_NOTES_KEY;
      case 'text':
        return TEXT_NOTES_KEY;
      default:
        return NOTES_KEY;
    }
  }
}
