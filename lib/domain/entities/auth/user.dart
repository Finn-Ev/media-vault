// this class only has the properties of the user that are relevant for this app
class CustomUser {
  final String id;
  final String email;
  final bool emailVerified;

  CustomUser({required this.id, required this.email, required this.emailVerified});
}
