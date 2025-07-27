import 'package:dartz/dartz.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';
import '../models/note_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NoteRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final localNotes = await localDataSource.getCachedNotes();
      return Right(localNotes.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getMusicNotes() async {
    try {
      final localNotes = await localDataSource.getCachedMusicNotes();
      return Right(localNotes.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getTextNotes() async {
    try {
      final localNotes = await localDataSource.getCachedTextNotes();
      return Right(localNotes.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addNote(Note note, String category) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      await localDataSource.addNote(noteModel, category);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(Note note, String category) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      await localDataSource.updateNote(noteModel, category);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String noteId, String category) async {
    try {
      await localDataSource.deleteNote(noteId, category);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
