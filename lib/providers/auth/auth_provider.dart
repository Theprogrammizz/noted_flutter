import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/services/auth_services.dart';

final authServiceProvider = Provider<AuthServices>((ref){
  return AuthServices();
});