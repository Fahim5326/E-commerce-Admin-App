import 'package:ecom_admin/auth/auth_service.dart';
import 'package:ecom_admin/pages/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isObscure = true;
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 4),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 4),
                child: TextFormField(
                  obscureText: isObscure,
                  controller: _passController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: _loginAdmin,
                  child: const Text('LOGIN'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(errMsg, style: const TextStyle(fontSize: 16, color: Colors.red,),),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loginAdmin() async {
    if(_formkey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passController.text;
      EasyLoading.show(status: 'Please Wait');
      try {
        final status = await AuthService.loginAdmin(email, password);
        EasyLoading.dismiss();
        if(status) {
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        } else {
          setState(() {
            errMsg = 'This email is not associated with an Admin account';
          });
        }
      } on FirebaseAuthException catch(error) {
        EasyLoading.dismiss();
        setState(() {
          errMsg = error.message!;
        });
      }
    }
  }
}
