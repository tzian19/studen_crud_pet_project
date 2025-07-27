import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetNotesEvent extends NotesEvent {}

class GetMusicNotesEvent extends NotesEvent {}

class GetTextNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;
  final String category;

  const AddNoteEvent({
    required this.note,
    required this.category,
  });

  @override
  List<Object> get props => [note, category];
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;
  final String category;

  const UpdateNoteEvent({
    required this.note,
    required this.category,
  });

  @override
  List<Object> get props => [note, category];
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;
  final String category;

  const DeleteNoteEvent({
    required this.noteId,
    required this.category,
  });

  @override
  List<Object> get props => [noteId, category];
}

class ChangeTabEvent extends NotesEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
