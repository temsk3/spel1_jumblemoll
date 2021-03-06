import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/auth/auth_repository.dart';

//  Instead of creating Two Screens, I have Added both Login and Signup Screen in one Screen
//  Yes , I am Lazy , But I am not going to create two screens , I am going to create one screen

//  So for to monitor we are in which State we are i.e Login or signUp , I have used enums here
//  So I have created and Enum Status which contains two things Login and SignUp

//  and I have made a Global Variable type of Status, to use in LoginPage
// It's actually not recommended to use Global Variables , but I am using it here to make it simple
//  The main motive here was to teach Firebase Authentication using Riverpod as state management

enum Status {
  login,
  signUp,
}

Status type = Status.login;

//  I have used stateful widget to use setstate functions in LoginPage
//  we could also managed the state using Riverpod but I am not using it here
//  Remember Stateful widgets are made for a reason. If it would be bad
//  flutter developer would not think of it in the first place.

class LoginPage extends StatefulWidget {
  static const routename = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  GlobalKey is used to validate the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  //  TextEditingController to get the data from the TextFields
  //  we can also use Riverpod to manage the state of the TextFields
  //  but again I am not using it here
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _name = TextEditingController();

  //  A loading variable to show the loading animation when you a function is ongoing
  bool _isLoading = false;
  bool _isLoading2 = false;
  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void loading2() {
    setState(() {
      _isLoading2 = !_isLoading2;
    });
  }

  void _switchType() {
    if (type == Status.signUp) {
      setState(() {
        type = Status.login;
      });
    } else {
      setState(() {
        type = Status.signUp;
      });
    }
    // print(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            //  Consuming a provider using watch method and storing it in a variable
            //  Now we will use this variable to access all the functions of the
            //  authentication
            final auth = ref.watch(authenticationProvider);

            //  Instead of creating a clutter on the onPressed Function
            //  I have decided to create a seperate function and pass them into the
            //  respective parameters.
            //  if you want you can write the exact code in the onPressed function
            //  it all depends on personal preference and code readability
            Future<void> _onPressedFunction() async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              // print(_email.text); // This are your best friend for debugging things
              //  not to mention the debugging tools
              // print(_password.text);
              if (type == Status.login) {
                loading();
                await auth
                    .signInWithEmailAndPassword(
                        _email.text, _password.text, context)
                    .whenComplete(
                        () => auth.authStateChange.listen((event) async {
                              if (event == null) {
                                loading();
                                return;
                              }
                            }));
              } else {
                loading();
                await auth
                    .signUpWithEmailAndPassword(
                        _name.text, _email.text, _password.text, context, ref)
                    .whenComplete(
                        () => auth.authStateChange.listen((event) async {
                              if (event == null) {
                                loading();
                                return;
                              }
                            }));
              }

              //  I had said that we would be using a Loading spinner when
              //  some functions are being performed. we need to check if some
              //  error occured then we need to stop loading spinner so we can retry
              //  Authenticating
            }

            Future<void> _loginWithGoogle() async {
              loading2();
              await auth.signInWithGoogle(context, ref).whenComplete(
                  () => auth.authStateChange.listen((event) async {
                        if (event == null) {
                          loading2();
                          return;
                        }
                      }));
            }

            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width >= 768 ? 400 : null,
                  width: 400,
                  // height: MediaQuery.of(context).size.width >= 768 ? null : 768,
                  height: 768,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            // margin: const EdgeInsets.only(top: 48),
                            margin: const EdgeInsets.only(top: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: const Center(
                                        child: Text(''))), //'jumble moll'))),
                                // const Center(child: FlutterLogo(size: 81)),
                                const Spacer(flex: 1),
                                if (type == Status.signUp)
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 600),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _name,
                                      autocorrect: true,
                                      enableSuggestions: true,
                                      keyboardType: TextInputType.name,
                                      onSaved: (value) {},
                                      decoration: const InputDecoration(
                                        hintText: 'Full Name',
                                        // hintStyle: const TextStyle(color: Colors.black54),
                                        icon: Icon(
                                          Icons.person,
                                          // color: Colors.blue.shade700, size: 24,
                                        ),
                                        alignLabelWithHint: true,
                                        // border: InputBorder.none,
                                      ),
                                      validator: type == Status.signUp
                                          ? (value) {
                                              if (value!.isEmpty) {
                                                return 'invalid! please try another one!';
                                              }
                                              return null;
                                            }
                                          : null,
                                    ),
                                  ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: _email,
                                    autocorrect: true,
                                    enableSuggestions: true,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (value) {},
                                    decoration: const InputDecoration(
                                      hintText: 'Email address',
                                      // hintStyle: const TextStyle(color: Colors.black54),
                                      icon: Icon(
                                        Icons.email_outlined,
                                        // color: Colors.blue.shade700, size: 24,
                                      ),
                                      alignLabelWithHint: true,
                                      // border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Invalid email!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: _password,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      // hintStyle: const TextStyle(color: Colors.black54),
                                      icon: Icon(
                                        CupertinoIcons.lock_circle,
                                        // color: Colors.blue.shade700,
                                        size: 24,
                                      ),
                                      alignLabelWithHint: true,
                                      // border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                if (type == Status.signUp)
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 600),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Confirm password',
                                        // hintStyle:
                                        //     const TextStyle(color: Colors.black54),
                                        icon: Icon(
                                          CupertinoIcons.lock_circle,
                                          // color: Colors.blue.shade700,
                                          size: 24,
                                        ),
                                        alignLabelWithHint: true,
                                        // border: InputBorder.none,
                                      ),
                                      validator: type == Status.signUp
                                          ? (value) {
                                              if (value != _password.text) {
                                                return 'Passwords do not match!';
                                              }
                                              return null;
                                            }
                                          : null,
                                    ),
                                  ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // flex: 2,
                          child: SizedBox(
                            width: double.infinity,
                            // decoration: const BoxDecoration(color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  width: double.infinity,
                                  child: _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : MaterialButton(
                                          onPressed: _onPressedFunction,
                                          // textColor: Colors.blue.shade700,
                                          textTheme: ButtonTextTheme.primary,
                                          minWidth: 100,
                                          padding: const EdgeInsets.all(18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            // side: const BorderSide(
                                            //     color: Colors.blue.shade700,
                                            //     ),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                  .unselectedWidgetColor,
                                            ),
                                          ),
                                          child: Text(
                                            type == Status.login
                                                ? 'Log in'
                                                : 'Sign up',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                ),
                                // Container(
                                //   padding: const EdgeInsets.only(top: 32.0),
                                //   margin:
                                //       const EdgeInsets.symmetric(horizontal: 16),
                                //   width: double.infinity,
                                //   child: _isLoading2
                                //       ? const Center(
                                //           child: CircularProgressIndicator())
                                //       : MaterialButton(
                                //           onPressed: _loginWithGoogle,
                                //           // textColor: Colors.blue.shade700,
                                //           textTheme: ButtonTextTheme.primary,
                                //           minWidth: 100,
                                //           padding: const EdgeInsets.all(18),
                                //           shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(25),
                                //             // side: const BorderSide(
                                //             // color: Colors.blue.shade700,
                                //             // ),
                                //             side: BorderSide(
                                //               color: Theme.of(context)
                                //                   .unselectedWidgetColor,
                                //             ),
                                //           ),
                                //           child: Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: const [
                                //               //  A google icon here
                                //               //  an External Package used here
                                //               //  Font_awesome_flutter package used
                                //               FaIcon(FontAwesomeIcons.google),
                                //               Text(
                                //                 ' Login with Google',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.w600),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                // ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: type == Status.login
                                          ? 'Don\'t have an account? '
                                          : 'Already have an account? ',
                                      // style: const TextStyle(
                                      // color: Colors.black,
                                      // ),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      children: [
                                        TextSpan(
                                            text: type == Status.login
                                                ? 'Sign up now'
                                                : 'Log in',
                                            style: TextStyle(
                                                //     color: Colors.blue.shade700,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _switchType();
                                              })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
