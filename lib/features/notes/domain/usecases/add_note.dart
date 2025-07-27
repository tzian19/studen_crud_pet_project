import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class AddNoteParams {
  final Note note;
  final String category;

  const AddNoteParams({
    required this.note,
    required this.category,
  });
}

class AddNote implements UseCase<void, AddNoteParams> {
  final NoteRepository repository;

  AddNote(this.repository);

  @override
  Future<Either<Failure, void>> call(AddNoteParams params) async {
    return await repository.addNote(params.note, params.category);
  }
}
