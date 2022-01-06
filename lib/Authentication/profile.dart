import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    final photo = user?.photoURL;
    final name = user?.displayName;
    final email = user?.email;
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photo!),
          ),
          Text('Name: ' + name!),
          Text('Email : ' + email!),
          Center(
            child: ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
