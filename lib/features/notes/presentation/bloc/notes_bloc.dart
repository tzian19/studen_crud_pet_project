import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/get_music_notes.dart';
import '../../domain/usecases/get_text_notes.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/update_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotes getNotes;
  final GetMusicNotes getMusicNotes;
  final GetTextNotes getTextNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NotesBloc({
    required this.getNotes,
    required this.getMusicNotes,
    required this.getTextNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NotesInitial()) {
    on<GetNotesEvent>(_onGetNotes);
    on<GetMusicNotesEvent>(_onGetMusicNotes);
    on<GetTextNotesEvent>(_onGetTextNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<ChangeTabEvent>(_onChangeTab);
  }

  Future<void> _onGetNotes(GetNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    
    final notesResult = await getNotes(const NoParams());
    final musicNotesResult = await getMusicNotes(const NoParams());
    final textNotesResult = await getTextNotes(const NoParams());

    final results = await Future.wait([
      Future.value(notesResult),
      Future.value(musicNotesResult),
      Future.value(textNotesResult),
    ]);

    final hasFailure = results.any((result) => result.isLeft());
    
    if (hasFailure) {
      emit(const NotesError(message: 'Failed to load notes'));
    } else {
      final notes = results[0].getOrElse(() => []);
      final musicNotes = results[1].getOrElse(() => []);
      final textNotes = results[2].getOrElse(() => []);
      
      emit(NotesLoaded(
        notes: notes,
        musicNotes: musicNotes,
        textNotes: textNotes,
      ));
    }
  }

  Future<void> _onGetMusicNotes(GetMusicNotesEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      final result = await getMusicNotes(const NoParams());
      
      result.fold(
        (failure) => emit(NotesError(message: _mapFailureToMessage(failure))),
        (musicNotes) => emit(currentState.copyWith(musicNotes: musicNotes)),
      );
    }
  }

  Future<void> _onGetTextNotes(GetTextNotesEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      final result = await getTextNotes(const NoParams());
      
      result.fold(
        (failure) => emit(NotesError(message: _mapFailureToMessage(failure))),
        (textNotes) => emit(currentState.copyWith(textNotes: textNotes)),
      );
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final result = await addNote(AddNoteParams(
        note: event.note,
        category: event.category,
      ));

      result.fold(
        (failure) => emit(NotesError(message: _mapFailureToMessage(failure))),
        (_) => add(GetNotesEvent()), // Refresh all notes
      );
    }
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final result = await updateNote(UpdateNoteParams(
        note: event.note,
        category: event.category,
      ));

      result.fold(
        (failure) => emit(NotesError(message: _mapFailureToMessage(failure))),
        (_) => add(GetNotesEvent()), // Refresh all notes
      );
    }
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) async {
    if (state is NotesLoaded) {
      final result = await deleteNote(DeleteNoteParams(
        noteId: event.noteId,
        category: event.category,
      ));

      result.fold(
        (failure) => emit(NotesError(message: _mapFailureToMessage(failure))),
        (_) => add(GetNotesEvent()), // Refresh all notes
      );
    }
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<NotesState> emit) {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      emit(currentState.copyWith(selectedTabIndex: event.tabIndex));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case CacheFailure:
        return 'Cache error occurred';
      case NetworkFailure:
        return 'Network error occurred';
      case ValidationFailure:
        return (failure as ValidationFailure).message;
      default:
        return 'Unexpected error occurred';
    }
  }
}
