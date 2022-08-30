import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isupply/blocs/auth_cubit/auth_cubit.dart';
import 'package:isupply/components/inputs/input_button.dart';
import 'package:isupply/components/inputs/input_field.dart';

import '../../components/header.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = AuthCubit.of(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Header(),
                InputField(
                  width: width * 0.85,
                  controller: cubit.otpCtrl,
                  labelText: "OTP",
                  labelStyle: Theme.of(context).textTheme.button,
                  numbersOnly: true,
                  hintText: "OTP",
                  counter: const Text("You can resend after 120 seconds"),
                  maxChars: null,
                ),
                InputButton(
                  onPressed: cubit.verifyOTP,
                  text: "Confirm",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
