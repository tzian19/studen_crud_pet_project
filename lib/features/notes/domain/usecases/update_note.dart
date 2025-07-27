import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateNoteParams {
  final Note note;
  final String category;

  const UpdateNoteParams({
    required this.note,
    required this.category,
  });
}

class UpdateNote implements UseCase<void, UpdateNoteParams> {
  final NoteRepository repository;

  UpdateNote(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateNoteParams params) async {
    return await repository.updateNote(params.note, params.category);
  }
}
