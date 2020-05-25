import 'package:fr/user.dart';
import 'package:fr/database.dart';
import 'package:fr/constants.dart';
import 'package:fr/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String Membername;
  String Mobilenumber;
  int Membershipnumber;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Member details',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.Membername,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a Membername' : null,
                    onChanged: (val) => setState(() => Membername = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.Membername,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a Mobilenumber' : null,
                    onChanged: (val) => setState(() => Mobilenumber = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.Membername,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a Membershipnumber' : null,
                    onChanged: (val) => setState(() => Membershipnumber = int.parse(val)),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              Membername ?? snapshot.data.Membername,
                              Mobilenumber ?? snapshot.data.Mobilenumber,
                              Membershipnumber ?? snapshot.data.Membershipnumber
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}