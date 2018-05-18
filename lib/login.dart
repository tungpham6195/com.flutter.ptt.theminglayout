import 'package:flutter/material.dart';
import 'package:my_theming_app/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
            primaryColor: color,
          ),
    );
  }  
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            new Column(
              children: <Widget>[
                new Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                new Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 120.0),
            PrimaryColorOverride(
              color: kShrineBrown900,
              child: new TextField(
                controller: _usernameController,
                decoration: new InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryColorOverride(
              color: kShrineBrown900,
              child: new TextField(
                controller: _passwordController,
                decoration: new InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: _clearTextField,
                ),
                new RaisedButton(
                  child: new Text('NEXT'),
                  onPressed: () {
                    print(_evenCasesIndex(2));
                    // Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  int _oddCasesIndex(int input) {
    assert(input > 0);
    return (input / 2).ceil() * 3 - 1;
  }

  int _evenCasesIndex(int input) {
    return input ~/ 2 * 3;
  }

  void _clearTextField() {
    _usernameController.clear();
    _passwordController.clear();
  }
}
