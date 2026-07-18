import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _auth.authStateChanges().listen((_) {
      _checkAuth();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserEntity? get currentUser => state.user;

  String? get currentRole => state.user?.role;

  bool get isAdmin => currentRole == 'admin';

  bool get isSeller => currentRole == 'seller';

  bool get isBuyer => currentRole == 'buyer';

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value, error: null);
  }

  void _setError(String message) {
    state = state.copyWith(isLoading: false, error: message);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  String _firebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Email tidak ditemukan';

      case 'wrong-password':
        return 'Password salah';

      case 'invalid-email':
        return 'Email tidak valid';

      case 'email-already-in-use':
        return 'Email sudah digunakan';

      case 'weak-password':
        return 'Password terlalu lemah';

      case 'network-request-failed':
        return 'Internet bermasalah';

      default:
        return e.message ?? 'Terjadi kesalahan';
    }
  }

  // ================= LOGIN =================

  Future<void> login(String email, String password) async {
    try {
      _setLoading(true);

      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      print("LOGIN FIREBASE BERHASIL");

      await credential.user?.reload();

      final firebaseUser = _auth.currentUser;

      if (firebaseUser == null) {
        _setError("User tidak ditemukan");
        return;
      }

      print("UID : ${firebaseUser.uid}");
      print("EMAIL : ${firebaseUser.email}");
      print("VERIFIED : ${firebaseUser.emailVerified}");

      // ============================
      // AKTIFKAN LAGI SAAT PRODUCTION
      // ============================
      /*
      if (!firebaseUser.emailVerified) {
        await _auth.signOut();
        _setError("Silakan verifikasi email terlebih dahulu");
        return;
      }
      */

      final user = await _getUserData(firebaseUser.uid);

      if (user == null) {
        _setError("Data user tidak ditemukan");
        return;
      }

      print("ROLE : ${user.role}");

      state = AuthState(isLoading: false, isAuthenticated: true, user: user);

      print("LOGIN BERHASIL");
    } on FirebaseAuthException catch (e) {
      _setError(_firebaseError(e));
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ================= REGISTER =================

  Future<void> register(String email, String password, String role) async {
    try {
      _setLoading(true);

      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = result.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await result.user!.sendEmailVerification();

      await _auth.signOut();

      state = const AuthState(
        isLoading: false,
        error: "Registrasi berhasil. Silakan cek email untuk verifikasi.",
      );
    } on FirebaseAuthException catch (e) {
      _setError(_firebaseError(e));
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ================= CHECK AUTH =================

  Future<void> _checkAuth() async {
    try {
      final firebaseUser = _auth.currentUser;

      if (firebaseUser == null) {
        state = const AuthState();
        return;
      }

      await firebaseUser.reload();

      final refreshedUser = _auth.currentUser;

      if (refreshedUser == null) {
        state = const AuthState();
        return;
      }

      // ============================
      // AKTIFKAN LAGI SAAT PRODUCTION
      // ============================
      /*
      if (!refreshedUser.emailVerified) {
        state = const AuthState();
        return;
      }
      */

      final user = await _getUserData(refreshedUser.uid);

      if (user != null) {
        state = AuthState(isAuthenticated: true, user: user);
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ================= FIRESTORE =================

  Future<UserEntity?> _getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        print("USER TIDAK ADA");
        return null;
      }

      final data = doc.data()!;

      return UserEntity(
        uid: data['uid'] ?? uid,
        email: data['email'] ?? '',
        role: data['role'] ?? 'buyer',
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> refreshUser() async {
    await _checkAuth();
  }

  Future<void> logout() async {
    await _auth.signOut();
    state = const AuthState();
  }
}
