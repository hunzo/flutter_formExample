import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

const kTextFields = TextStyle(fontSize: 16, color: Colors.black);
const kButton = TextStyle(fontSize: 18, color: Colors.white);

class _AppState extends State<App> {
  final formkey = GlobalKey<FormState>();

  String username;
  String password;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          print("Gesture detect !!!");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login Screen Example'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.grey[800], fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      style: kTextFields,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                        suffix: Text('user@domain.name'),
                        prefixIcon: Icon(Icons.email),
                      ),
                      onSaved: (String value) {
                        print(value);
                        setState(() {
                          username = value;
                        });
                      },
                      validator: (String value) {
                        if (!validateEmail(value)) {
                          return 'Invalid email pattern';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: kTextFields,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      onSaved: (String value) {
                        print(value);
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (String value) {
                        if (value.length < 8) {
                          return 'Password lengh  must be more than 8 charactor';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState.validate()) {
                              formkey.currentState.save();
                              print(
                                  'email address: $username, password: $password');
                              // formkey.currentState.reset();

                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                          child: Text(
                            'Login',
                            style: kButton,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              setState(() {
                                username = '';
                                password = '';
                              });
                              formkey.currentState.reset();
                            },
                            child: Text(
                              'Reset',
                              style: kButton,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("username: $username\npassword: $password")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
