import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forgotpassword extends StatefulWidget {

  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final _formKey = GlobalKey<FormState>();
  var email="";
  var error="";
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xff0E1E37),

        bottomOpacity: 0,
      ),
      body: Row(
        children: [
          HomeLeftPane(measure: MediaQuery.of(context).size.height),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(100, 18, 8, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    validator: (ch1) => ch1!.length < 6
                        ? 'please ensure that password has more than six characters'
                        : null,
                    decoration: InputDecoration(
                        labelText: 'enter email'),
                    onChanged: (ch1) {
                      setState(() {
                        email = ch1;
                      });
                    },
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          try {
                            await _auth.resetPassword(email);


                            Navigator.pop(context);
                          } on Exception catch (e) {
                            // TODO
                            setState(() {
                              error=e.toString();
                            });
                          }



                        }
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
class HomeLeftPane extends StatelessWidget {
  double measure;
  HomeLeftPane({required this.measure});

  Widget build(BuildContext c) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: measure * 0.6,
      height: measure,
      color: Color(0xff0E1E37),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 10, 10),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Reset Password',
                    textStyle: const TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 100,
                pause: const Duration(milliseconds: 3000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 140, 40, 10),
            child: Text(
                "Email will be sent to your email address , to reset password",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ),

        ],
      ),
    );
  }
}