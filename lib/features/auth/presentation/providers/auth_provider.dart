import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier()
      : super(FirebaseAuth.instance.currentUser);

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> login(
    String email,
    String password,
  ) async {
    final credential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    state = credential.user;
  }

  Future<void> register(
    String email,
    String password,
    String role,
  ) async {
    final credential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore
        .collection("users")
        .doc(credential.user!.uid)
        .set({
      "uid": credential.user!.uid,
      "email": email,
      "role": role,
    });

    state = credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
    state = null;
  }
}