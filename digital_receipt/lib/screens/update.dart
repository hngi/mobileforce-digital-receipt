// import 'dart:async';
// import 'dart:convert' show json, jsonEncode;

// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// GoogleSignIn _googleSignIn = new GoogleSignIn(clientId:"555414249433-qg0gt6hv2assajrufmcgtpi1bu3u02ts.apps.googleusercontent.com",
//   scopes: <String>[
//     'profile',
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }

// class SignInDemo extends StatefulWidget {
//   @override
//   State createState() => SignInDemoState();
// }

// class SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;
//   String token;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//       _googleSignIn.signInSilently();
//       _googleSignIn.signIn().then((result){
//         result.authentication.then((googleKey){
//           String token = googleKey.idToken;
//           print(googleKey.accessToken);
//           print(googleKey.idToken);
//           print(_googleSignIn.currentUser.displayName);
//           print(_googleSignIn.currentUser.id);
//           print(_googleSignIn.currentUser.toString());
//         }).catchError((err){
//           print('inner error');
//         });
//       }).catchError((err){
//         print('error occured');
//       });
//     });
//   }


//   Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }

//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//           (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//             (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     if (_currentUser != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: _currentUser,
//             ),
//             title: Text(_currentUser.displayName ?? ''),
//             subtitle: Text(_currentUser.email ?? ''),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText ?? ''),
//           RaisedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           RaisedButton(
//             child: const Text('REFRESH'),
//             onPressed: _handleGetContact,
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           RaisedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }

// Future<Album> createAlbum(String title) async {
//   final http.Response response = await http.post(
//     'https://hng-degeit-receipt.herokuapp.com/google',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': _googleSignIn.currentUser.toString(),
//     }),
//   );

//   if (response.statusCode == 201) {
//     return Album.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to create User id.');
//   }
// }

// class Album {
//   final String id;

//   Album({this.id});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//     );
//   }
// }
