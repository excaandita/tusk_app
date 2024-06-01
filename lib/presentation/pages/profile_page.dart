import 'package:d_info/d_info.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tusk_app/common/app_color.dart';
import 'package:tusk_app/common/app_route.dart';
import 'package:tusk_app/data/models/user.dart';
import 'package:tusk_app/presentation/bloc/user/user_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          appBar(),
          header(),
          const Gap(30),
          buildItemMenu(Icons.edit, 'Edit Profile'),
          const Gap(16),
          buildItemMenu(Icons.settings, 'Settings'),
          const Gap(16),
          buildItemMenu(Icons.feedback, 'Feedback'),
          const Gap(16),
          buildItemMenu(Icons.lock, 'Change Password'),
          const Gap(16),
          buildItemMenu(Icons.logout, 'Log Out', (){
            DInfo.dialogConfirmation(
              context, 
              "Log Out", 
              "Are you sure you want to log out ?"
            ).then((yes) {
              if(yes??false) {
                DSession.removeUser();
                context.read<UserCubit>().update(User());
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  AppRoute.login, 
                  (route) => route.settings.name == AppRoute.home
                );
              }
            });
          }),
          const Gap(30),
        ],
      ),
    );
  }

  Widget buildItemMenu(IconData icon, String title, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColor.primary,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColor.textTitle,
                  fontSize: 14,
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: AppColor.primary,
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        Container(
          height: 140,
          color: AppColor.primary,
          margin: EdgeInsets.only(bottom: 60),
        ),
        Positioned(
          top: 60,
          left: 30,
          right: 30,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<UserCubit, User>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      state.name??'',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textTitle,
                        fontSize: 18
                      ),
                    ),
                    const Gap(6),
                    Text(
                      state.email??'',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textBody,
                        fontSize: 14
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ] 
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/profile.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: const Text("Profile"),
      centerTitle: true,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BackButton(
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
