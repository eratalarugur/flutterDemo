import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:ali_ugur_eratalar_proj/services/auth.dart';
import 'package:ali_ugur_eratalar_proj/routes/register.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String mail = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',
                            labelStyle: regularTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (String? value) {
                            if(value == null) {
                              return 'ERROR';
                            } else {
                              if(value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              if(!EmailValidator.validate(value)) {
                                return 'The e-mail address is not valid';
                              }
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            mail = value ?? '';
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',
                            labelStyle: regularTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (String? value) {
                            if(value == null) {
                              return 'ERROR';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if(value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value ?? '';
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () async {

                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              dynamic result = await _auth.signInWithEmailAndPass(mail, pass);

                              if(result == null) {
                                print('Login failed');
                              }
                              else {
                                print('User logged in');
                              }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Logging in')));
                            }

                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style: primaryButtonTextStyle,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(
              height: 24,
              thickness: 2,
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Sign in anonymously',
                      style: secondaryButtonTextStyle,
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.appBarTitleColor,
                    ),
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if(result == null){
                        print('error signing in');
                      } else {
                        print('signed in');
                        print(result.uid);
                      }
                    },
                  ),
                ),
              ],
            ),


            const Divider(
              height: 24,
              thickness: 2,
            ),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text(
                      'Don\'t have an account yet? Register now!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey[800],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}