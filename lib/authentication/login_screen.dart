import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/gloval.dart';
import 'package:users_app/mainScreens/home_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/error_dialog.dart';
import 'package:users_app/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: 'Please write email/password',
          );
        },
      );
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: 'Checking credentials.',
        );
      },
    );

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
        },
      );
    });

    if (currentUser != null) {
      readAndSetDataLocally(currentUser!).then(
        (value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) => const HomeScreen(),
            ),
          );
        },
      );
    }
  }

  Future readAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then(
      (snapshot) async {
        await sharedPreferences!.setString('uid', currentUser.uid);
        await sharedPreferences!.setString('email', snapshot.data()!['email']);
        await sharedPreferences!.setString('name', snapshot.data()!['name']);
        await sharedPreferences!
            .setString('photoUrl', snapshot.data()!['photoUrl']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'images/photo_2022-06-08_19-09-43_4.jpg',
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: 'Email',
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: 'Password',
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 10,
              ),
            ),
            onPressed: () {
              formValidation();
            },
          ),
        ],
      ),
    );
  }
}
