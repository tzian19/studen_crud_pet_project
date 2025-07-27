import 'package:dartz/dartz.dart';
import '../repositories/note_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteNoteParams {
  final String noteId;
  final String category;

  const DeleteNoteParams({
    required this.noteId,
    required this.category,
  });
}

class DeleteNote implements UseCase<void, DeleteNoteParams> {
  final NoteRepository repository;

  DeleteNote(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteNoteParams params) async {
    return await repository.deleteNote(params.noteId, params.category);
  }
}
