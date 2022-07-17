abstract class MediaFailure {}

class InsufficientPermissions extends MediaFailure {}

class UnexpectedFailure extends MediaFailure {}

String mapTodosFailureToMessage(MediaFailure failure) {
  switch (failure.runtimeType) {
    case InsufficientPermissions:
      return 'Insufficient Permissions. Please relaunch the app';
    case UnexpectedFailure:
      return 'Something went wrong';
    default:
      return 'Unexpected Error';
  }
}
