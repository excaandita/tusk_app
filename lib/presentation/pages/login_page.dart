import 'package:d_input/d_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tusk_app/common/app_color.dart';
import 'package:tusk_app/common/app_info.dart';
import 'package:tusk_app/common/app_route.dart';
import 'package:tusk_app/common/enums.dart';
import 'package:tusk_app/presentation/bloc/login/login_cubit.dart';
import 'package:tusk_app/presentation/bloc/user/user_cubit.dart';
import 'package:tusk_app/presentation/widgets/app_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final edtEmail = TextEditingController();
    final edtPassword = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          buildHeader(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                DInput(
                  controller: edtEmail,
                  fillColor: Colors.white,
                  radius: BorderRadius.circular(12),
                  hint: 'E-mail',
                ),
                const SizedBox(height: 20),
                DInputPassword(
                  controller: edtPassword,
                  fillColor: Colors.white,
                  radius: BorderRadius.circular(12),
                  hint: 'Password',
                ),
                const SizedBox(height: 20),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if(state.requestStatus == RequestStatus.failed) {
                      AppInfo.failed(context, 'Login failed');
                    }
                    if(state.requestStatus == RequestStatus.success) {
                      AppInfo.success(context, 'Login Success');
                      Navigator.pushNamed(context, AppRoute.home);
                    }
                  },
                  builder: (context, state) {
                    if(state.requestStatus == RequestStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AppButton.primary('LOGIN', () {
                      context
                        .read<LoginCubit>()
                        .clickLogin(edtEmail.text, edtPassword.text);
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AspectRatio buildHeader() {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            bottom: 100,
            child: Image.asset(
              'assets/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              top: 120,
              bottom: 90,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColor.scaffold,
                        Colors.transparent,
                      ]),
                ),
              )),
          Positioned(
            left: 30,
            right: 30,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                      text: 'Monitoring\n',
                      style: TextStyle(
                        color: AppColor.defaultText,
                        fontSize: 26,
                        height: 1.4,
                      ),
                      children: const [
                        TextSpan(text: 'with '),
                        TextSpan(
                          text: 'Tusk ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
