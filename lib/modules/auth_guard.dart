import 'package:flutter_modular/flutter_modular.dart';
import 'package:isupply/utils/cache_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async =>
      CacheService.getInstance().has("token");
}
