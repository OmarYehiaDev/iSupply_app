import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:isupply/backend/middleware.dart';
import 'package:isupply/blocs/auth_cubit/auth_cubit.dart';
import 'package:isupply/views/auth/login_screen.dart';
import 'package:isupply/views/auth/otp_verification_screen.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        RedirectRoute('/auth', to: '/auth/login'),
        ChildRoute(
          "/login",
          child: (context, args) => BlocProvider(
            create: (context) => AuthCubit(ApiService()),
            child: const LoginScreen(),
          ),
        ),
        ChildRoute(
          "/verify-otp",
          child: (context, args) => BlocProvider(
            create: (context) => AuthCubit(ApiService()),
            child: const OtpVerificationView(),
          ),
        ),
      ];
}
