import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import 'auth_state.dart';



final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});





class AuthNotifier extends StateNotifier<AuthState> {


  AuthNotifier()
      : super(const AuthState()) {


    _authListener =
        _auth.authStateChanges().listen((user) {

      _checkAuth();

    });


  }




  final FirebaseAuth _auth =
      FirebaseAuth.instance;


  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;



  StreamSubscription<User?>? _authListener;





  UserEntity? get currentUser =>
      state.user;



  String? get currentRole =>
      state.user?.role;



  bool get isAdmin =>
      currentRole == 'admin';



  bool get isSeller =>
      currentRole == 'seller';



  bool get isBuyer =>
      currentRole == 'buyer';






  void _setLoading(bool value){

    state = state.copyWith(
      isLoading:value,
      error:null,
    );

  }






  void _setError(String message){

    state = state.copyWith(
      isLoading:false,
      error:message,
    );

  }






  void clearError(){

    state =
        state.copyWith(
          error:null,
        );

  }







  String _firebaseError(
      FirebaseAuthException e){


    switch(e.code){


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



      case 'invalid-credential':
        return 'Email atau password salah';



      default:
        return e.message ??
            'Terjadi kesalahan';


    }


  }









// ================= LOGIN =================


Future<void> login(
    String email,
    String password,
) async {


try{


_setLoading(true);



final credential =
    await _auth.signInWithEmailAndPassword(

  email:email.trim(),

  password:password.trim(),

);



final firebaseUser =
    credential.user;



if(firebaseUser == null){

  _setError(
      "User tidak ditemukan");

  return;

}





final user =
    await _getUserData(
        firebaseUser.uid);





if(user == null){

  await logout();

  _setError(
      "Data user tidak ditemukan");

  return;

}





state = AuthState(

  isLoading:false,

  isAuthenticated:true,

  user:user,

);



}



on FirebaseAuthException catch(e){

_setError(
    _firebaseError(e));

}



catch(e){

_setError(
    e.toString());

}



}









// ================= REGISTER =================



Future<void> register(
    String email,
    String password,
    String role,
) async {



try{


_setLoading(true);




if(role != 'buyer' &&
   role != 'seller'){


  _setError(
      "Role tidak valid");


  return;


}






final result =
    await _auth.createUserWithEmailAndPassword(

  email:email.trim(),

  password:password.trim(),

);




final uid =
    result.user!.uid;





await _firestore
    .collection('users')
    .doc(uid)
    .set({


  'uid':uid,


  'email':email.trim(),


  'role':role,


  'createdAt':
      FieldValue.serverTimestamp(),


});






await result.user!
    .sendEmailVerification();






await _auth.signOut();






state = const AuthState(

  isLoading:false,

  error:
  "Registrasi berhasil. Silakan verifikasi email.",


);



}




on FirebaseAuthException catch(e){

_setError(
    _firebaseError(e));

}



catch(e){

_setError(
    e.toString());

}



}









// ================= CHECK AUTH =================



Future<void> _checkAuth() async {


try{


final firebaseUser =
    _auth.currentUser;



if(firebaseUser == null){

state =
const AuthState();

return;

}





final user =
    await _getUserData(
        firebaseUser.uid);





if(user != null){


state = AuthState(

isAuthenticated:true,

user:user,

);


}



}



catch(e){

_setError(
    e.toString());

}



}









// ================= GET USER =================



Future<UserEntity?> _getUserData(
    String uid
) async {


try{


final doc =
    await _firestore
        .collection('users')
        .doc(uid)
        .get();




if(!doc.exists){

return null;

}




final data =
    doc.data();



if(data == null){

return null;

}





return UserEntity(

uid:data['uid'] ?? uid,


email:data['email'] ?? '',


role:data['role'] ?? 'buyer',


);



}

catch(_){

return null;

}



}









// ================= ADMIN USERS =================



Future<List<UserEntity>> getAllUsers() async {


final snapshot =
    await _firestore
        .collection('users')
        .get();




return snapshot.docs.map((doc){


final data =
    doc.data();




return UserEntity(

uid:data['uid'] ?? doc.id,


email:data['email'] ?? '',


role:data['role'] ?? 'buyer',


);



}).toList();



}







Future<void> updateUserRole(
    String uid,
    String role,
) async {


await _firestore
    .collection('users')
    .doc(uid)
    .update({


  'role':role,


});



}







Future<void> deleteUserData(
    String uid,
) async {


await _firestore
    .collection('users')
    .doc(uid)
    .delete();



}









Future<void> refreshUser() async {

await _checkAuth();

}









Future<void> logout() async {


await _auth.signOut();


state =
const AuthState();


}








@override
void dispose(){


_authListener?.cancel();


super.dispose();


}



}