import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kbn_test/veiw/auth/login.dart';
import 'package:kbn_test/veiw/auth/signup_acc.dart';
import 'package:kbn_test/veiw/auth/signup_education.dart';
import 'package:kbn_test/veiw/auth/signup_personal.dart';
import 'package:kbn_test/veiw/auth/signup_skill.dart';
import 'package:kbn_test/veiw/screen/home.dart';

class AppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: 'login',
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: LogInPage());
      },
    ),
    GoRoute(
      name: 'signup_personalinformation',
      path: '/signup_personalinformation',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignupPersonal());
      },
    ),
    GoRoute(
      name: 'signup_educationalinformation',
      path: '/signup_educationalinformation',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignupEducation());
      },
    ),
    GoRoute(
      name: 'signup_skillsandexperiances',
      path: '/signup_skillsandexperiances',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignupSkill());
      },
    ),
    GoRoute(
      name: 'signup_accountinformation',
      path: '/signup_accountinformation',
      pageBuilder: (context, state) {
        return const MaterialPage(child: const SignupAcc());
      },
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      pageBuilder: (context, state) {
        return const MaterialPage(child: Home());
      },
    ),
  ]);
}
