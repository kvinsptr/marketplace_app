import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';
import '../../data/user_model.dart';
import '../../domain/entities/user_entity.dart';


final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier();
  },
);



class AuthNotifier extends StateNotifier<AuthState> {

  AuthNotifier()
      : super(
          const AuthState(),
        ) {

    _checkAuth();

  }



  final FirebaseAuth _auth =
      FirebaseAuth.instance;


  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;




  Future<void> _checkAuth() async {

    final firebaseUser =
        _auth.currentUser;


    if(firebaseUser == null){

      state = const AuthState();

      return;
    }


    final user =
        await _getUserData(
          firebaseUser.uid,
        );


    state = AuthState(
      isAuthenticated: true,
      user: user,
    );

  }





  Future<void> login(
    String email,
    String password,
  ) async {


    try {


      state = state.copyWith(
        isLoading: true,
        error: null,
      );


      final result =
          await _auth
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );



      final user =
          await _getUserData(
            result.user!.uid,
          );



      state = AuthState(
        isAuthenticated: true,
        user: user,
      );


    } on FirebaseAuthException catch(e){


      state = AuthState(
        error: e.message,
      );


    }

  }





  Future<void> register(
    String email,
    String password,
    String role,
  ) async {


    try {


      state = state.copyWith(
        isLoading: true,
        error: null,
      );



      final result =
          await _auth
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



      final uid =
          result.user!.uid;



      final user = UserModel(
        uid: uid,
        email: email,
        role: role,
      );



      await _firestore
          .collection(
            "users",
          )
          .doc(uid)
          .set(
            user.toMap(),
          );



      state = AuthState(
        isAuthenticated: true,
        user: UserEntity(
          uid: uid,
          email: email,
          role: role,
        ),
      );



    } on FirebaseAuthException catch(e){


      state = AuthState(
        error: e.message,
      );


    }

  }







  Future<UserEntity?> _getUserData(
    String uid,
  ) async {


    final doc =
        await _firestore
            .collection("users")
            .doc(uid)
            .get();



    if(!doc.exists){

      return null;

    }



    final model =
        UserModel.fromMap(
          doc.data()!,
        );


    return UserEntity(
      uid: model.uid,
      email: model.email,
      role: model.role,
    );

  }







  Future<void> logout() async {


    await _auth.signOut();


    state = const AuthState();

  }

}