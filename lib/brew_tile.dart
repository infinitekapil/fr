import 'package:fr/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({ this.brew });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Text('${brew.Membershipnumber}'),
          title: Text(brew.Membername),
          subtitle: Text('${brew.Mobilenumber}'),
        ),
      ),
    );
  }
}