import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/domain/entities/user_entity.dart';



final adminUsersProvider =
    FutureProvider<List<UserEntity>>((ref) async {


  final auth =
      ref.read(authProvider.notifier);



  return await auth.getAllUsers();


});