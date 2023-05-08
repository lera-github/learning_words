import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
const RegistrationPage({Key? key}) : super(key: key);

@override
_RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
late String _email;
late String _password;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
  title: const Text('Регистрация'),
),
body: Form(
key: _formKey,
child: Column(
children: <Widget>[
TextFormField(
validator: (input) {
if (input == null || input.isEmpty) {
return 'Please enter an email';
}
return null;
},
onSaved: (input) => _email = input!,
decoration: InputDecoration(
labelText: 'Email',
),
),
TextFormField(
validator: (input) {
if (input == null || input.length < 6) {
return 'Your password needs to be at least 6 characters';
}
return null;
},
onSaved: (input) => _password = input!,
decoration: InputDecoration(
labelText: 'Password',
),
obscureText: true,
),
ElevatedButton(
onPressed: () {
_submit();
},
child: const Text('Submit'),
)
],
),
),
);
}

void _submit() {
if (_formKey.currentState?.validate() ?? false) {
_formKey.currentState?.save();
// Send the email and password to your server for registration.
}
}
}

class LoginPage extends StatefulWidget {
const LoginPage({Key? key}) : super(key: key);

@override
_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
late String _email;
late String _password;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Вход'),
),
body: Form(
key: _formKey,
child: Column(
children: <Widget>[
TextFormField(
validator: (input) {
if (input == null || input.isEmpty) {
return 'Please enter an email';
}
return null;
},
onSaved: (input) => _email = input!,
decoration: const InputDecoration(
labelText: 'Email',
),
),
TextFormField(
validator: (input) {
if (input == null || input.isEmpty) {
return 'Please enter a password';
}
return null;
},
onSaved: (input) => _password = input!,
decoration: const InputDecoration(
labelText: 'Password',
),
obscureText: true,
),
ElevatedButton(
onPressed: () {
_submit();
},
child: const Text('Submit'),
)
],
),
),
);
}

void _submit() {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save();
// Send the email and password to your server for authentication.
}
}
}