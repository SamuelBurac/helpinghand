import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final List<String> scopes = <String>[
    'email',
  ];

  late final GoogleSignIn _googleSignIn;

  AuthService() {
    _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);

  }

  Future<void> resetPass(email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<String> createUserWEAndPass(email, password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user!.uid;
  }

  Future<void> updateEmail(email, password) async {
    if (user == null) {
      throw Exception('User is null');
    }
    AuthCredential credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );
    await user!.reauthenticateWithCredential(credential);
    await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
  }
}
