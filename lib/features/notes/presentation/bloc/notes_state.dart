import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  final List<Note> musicNotes;
  final List<Note> textNotes;
  final int selectedTabIndex;

  const NotesLoaded({
    required this.notes,
    required this.musicNotes,
    required this.textNotes,
    this.selectedTabIndex = 0,
  });

  List<Note> get currentNotes {
    switch (selectedTabIndex) {
      case 0:
        return notes;
      case 1:
        return musicNotes;
      case 2:
        return textNotes;
      default:
        return notes;
    }
  }

  NotesLoaded copyWith({
    List<Note>? notes,
    List<Note>? musicNotes,
    List<Note>? textNotes,
    int? selectedTabIndex,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      musicNotes: musicNotes ?? this.musicNotes,
      textNotes: textNotes ?? this.textNotes,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object> get props => [notes, musicNotes, textNotes, selectedTabIndex];
}

class NotesError extends NotesState {
  final String message;

  const NotesError({required this.message});

  @override
  List<Object> get props => [message];
}
