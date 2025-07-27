import 'package:get_it/get_it.dart';

// Core
import 'core/network/network_info.dart';

// Features - Notes
import 'features/notes/data/datasources/note_local_data_source.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/repositories/note_repository.dart';
import 'features/notes/domain/usecases/get_notes.dart';
import 'features/notes/domain/usecases/get_music_notes.dart';
import 'features/notes/domain/usecases/get_text_notes.dart';
import 'features/notes/domain/usecases/add_note.dart';
import 'features/notes/domain/usecases/update_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/presentation/bloc/notes_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Notes
  // Bloc
  sl.registerFactory(
    () => NotesBloc(
      getNotes: sl(),
      getMusicNotes: sl(),
      getTextNotes: sl(),
      addNote: sl(),
      updateNote: sl(),
      deleteNote: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotes(sl()));
  sl.registerLazySingleton(() => GetMusicNotes(sl()));
  sl.registerLazySingleton(() => GetTextNotes(sl()));
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => UpdateNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));

  // Repository
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
