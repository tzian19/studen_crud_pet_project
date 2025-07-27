import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../../../../core/error/failures.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, List<Note>>> getMusicNotes();
  Future<Either<Failure, List<Note>>> getTextNotes();
  Future<Either<Failure, void>> addNote(Note note, String category);
  Future<Either<Failure, void>> updateNote(Note note, String category);
  Future<Either<Failure, void>> deleteNote(String noteId, String category);
}