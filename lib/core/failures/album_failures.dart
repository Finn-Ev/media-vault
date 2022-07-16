abstract class AlbumFailure {}

class InsufficientPermissions extends AlbumFailure {}

class UnexpectedFailure extends AlbumFailure {}

String mapTodosFailureToMessage(AlbumFailure failure) {
  switch (failure.runtimeType) {
    case InsufficientPermissions:
      return 'Insufficient Permissions. Please relaunch the app';
    case UnexpectedFailure:
      return 'Something went wrong';
    default:
      return 'Unexpected Error';
  }
}
