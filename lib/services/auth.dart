import 'package:health_care/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyUser? _userFromFirebase(User? user) {
    return user != null
        ? MyUser(
            uid: user.uid,
            photoURL: user.photoURL ?? '',
            displayName: user.displayName ?? '',
            email: user.email ?? '',
          )
        : null;
  }

  // Stream for auth state change
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Code for signing in with Google goes here
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      assert(user != null && !user.isAnonymous);
      // ignore: unnecessary_null_comparison
      assert(await user!.getIdToken() != null);
      // ignore: unused_local_variable
      final User? currentUser = _auth.currentUser;
      if (user != null) {
        print("Sign in with Google succeeded");
        return user.uid;
      } else {
        throw Exception("Failed to sign in with Google. User is null.");
      }
    } catch (e) {
      print("Error in sign in with Google");
      print(e.toString());
      return '';
    }
  }

  // Code for sign out goes here
  Future<void> signOutGoogle() async {
    try {
      print("User Signed Out");
      await _auth.signOut();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      print("Error in sign out");
      print(e.toString());
    }
  }
}
