import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DjappFirebaseUser {
  DjappFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

DjappFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DjappFirebaseUser> djappFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<DjappFirebaseUser>((user) => currentUser = DjappFirebaseUser(user));
