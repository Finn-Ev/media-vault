abstract class AuthFailure {}

class ServerFailure extends AuthFailure {}

class EmailAlreadyInUseFailure extends AuthFailure {}

class InvalidEmailAndPasswordCombinationFailure extends AuthFailure {}

String mapAuthFailureToMessage(AuthFailure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Something went wrong';
    case EmailAlreadyInUseFailure:
      return 'Email already in use. Please try a different one';
    case InvalidEmailAndPasswordCombinationFailure:
      return 'Invalid email and password combination. Please try again';
    default:
      return 'Unexpected Error';
  }
}
