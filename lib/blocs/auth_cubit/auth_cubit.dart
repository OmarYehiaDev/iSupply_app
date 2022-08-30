import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:isupply/backend/middleware.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService api;
  AuthCubit(this.api) : super(AuthInitial());
  static AuthCubit of(BuildContext context) => BlocProvider.of(context);
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  bool? navigateToOTP;
  void loginOrRegister() async {
    final res = await api.loginOrRegister(phoneCtrl.text);
    res.fold(
      (l) => AuthFailed(l!),
      (r) {
        if (r.key.toLowerCase() == "success") {
          Modular.to.pushNamed("/auth/verify-otp");
        }
      },
    );
  }

  void verifyOTP() async {
    final res = await api.verifyOtp(phoneCtrl.text, otpCtrl.text);
    res.fold(
      (l) => AuthFailed(l!),
      (r) {
        if (r) {
          Modular.to.navigate("/employees/home");
        }
      },
    );
  }
}
