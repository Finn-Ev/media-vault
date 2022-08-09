abstract class LocalAuthFailure {}

//
class GeneralLocalAuthFailure extends LocalAuthFailure {}
//
// class EmailAlreadyInUseFailure extends LocalAuthFailure {}
//
// class EmailNotVerifiedFailure extends LocalAuthFailure {}
//
// class InvalidEmailAndPasswordCombinationFailure extends LocalAuthFailure {}
//
// String mapAuthFailureToMessage(LocalAuthFailure failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       return 'Something went wrong';
//     case EmailAlreadyInUseFailure:
//       return 'Email already in use. Please try a different one';
//     case EmailNotVerifiedFailure:
//       return 'Your email isn\'t verified. Please check your inbox';
//     case InvalidEmailAndPasswordCombinationFailure:
//       return 'Invalid email and password combination. Please try again';
//     default:
//       return 'Unexpected Error';
//   }
// }
