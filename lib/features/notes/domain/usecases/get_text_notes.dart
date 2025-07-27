import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetTextNotes implements UseCase<List<Note>, NoParams> {
  final NoteRepository repository;

  GetTextNotes(this.repository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) async {
    return await repository.getTextNotes();
  }
}
