abstract class RemoteAuthFailure {}

class ServerFailure extends RemoteAuthFailure {}

class EmailAlreadyInUseFailure extends RemoteAuthFailure {}

class EmailNotVerifiedFailure extends RemoteAuthFailure {}

class InvalidEmailAndPasswordCombinationFailure extends RemoteAuthFailure {}

String mapAuthFailureToMessage(RemoteAuthFailure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Something went wrong';
    case EmailAlreadyInUseFailure:
      return 'Email already in use. Please try a different one';
    case EmailNotVerifiedFailure:
      return 'Your email isn\'t verified. Please check your inbox';
    case InvalidEmailAndPasswordCombinationFailure:
      return 'Invalid email and password combination. Please try again';
    default:
      return 'Unexpected Error';
  }
}
