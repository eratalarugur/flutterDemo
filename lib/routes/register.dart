import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:ali_ugur_eratalar_proj/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  String? mail;
  String? pass;
  String? pass2;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        title: Text('Register'),
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
                            }
                            else {
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
                            mail = value;
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
                            labelStyle: subtitleTextStyle,
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
                            pass = value;
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
                              if(value != pass2) {
                                return 'Passwords don\'t match';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value;
                          },
                        ),
                      ),

                      SizedBox(width: 16,),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password (repeat)',
                            //labelText: 'Username',
                            labelStyle: subtitleTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            pass2 = value;

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
                              if(value != pass) {
                                return 'Passwords don\'t match';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value;
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

                              dynamic result = await _auth.signUpWithEmailAndPass(mail!, pass!);

                              if(result == null) {
                                print('Registration failed');
                              }
                              else {
                                print('User registered');
                              }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Logging in')));
                            }

                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Register',
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


          ],
        ),
      ),
    );
  }
}
