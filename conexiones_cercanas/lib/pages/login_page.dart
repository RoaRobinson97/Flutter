import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'init_page.dart';

class LoginPageWidget extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isUserSignedIn = false;
  double tama = 0;
  String texto = '';
  bool isLoading = false;

  @override
  void initState() {
    checkIfUserIsSignedIn();
    super.initState();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();
    FirebaseUser user;

    setState(() {
      if (userSignedIn == true) {
        tama = 0;
        texto = '';

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InitPage(user, _googleSignIn)));

        Future.delayed(const Duration(milliseconds: 2000), () {
          setState(() {
            tama = 500;
            texto = 'Sign in:';
          });
        });
      } else {
        tama = 500;
        texto = 'Sign in:';
      }
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(00, 00, 00, 0.5),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.white70,
    ));

    return Scaffold(
        drawer: Container(
          width: 250,
          child: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: Container(
              color: Color.fromRGBO(18, 20, 26, 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Text(
                      'Social Distance\'s purpose',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Text(
                      'Fence provides a modern solution to accomplish social distancing using our smartphones.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      '1. Sing in and turn on the bluetooth in your device.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(height: 30, child: Image.asset('assets/onOff.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      '2. Now your smartphone is scanning for nearby devices.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      width: 40, child: Image.asset('assets/blueIma.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      '3. If there is a device less than 2 meters away, your smartphone will let you know.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(height: 70, child: Image.asset('assets/phone.png')),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color.fromRGBO(55, 71, 79, 1), Colors.red])),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    )
                  : new Container(
                      padding: EdgeInsets.all(50),
                      child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 80),
                            child: Container(
                              width: tama,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      width: 200,
                                      child: Image.asset('assets/title.png')),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(texto,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        FlatButton(
                                            onPressed: () {
                                              onGoogleSignIn(context);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              child: Image.asset(
                                                  'assets/googleButton.png'),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color.fromRGBO(18, 20, 26, 1),
                ),
                height: 50,
                width: 50,
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.help,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await _handleSignIn();
    isLoading = true;

    Position _currentPosition;
    String _currentAddress;
    var database = FirebaseDatabase.instance.reference();

    final Geolocator geolocator = Geolocator();

    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    Placemark place = p[0];
    _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";

    database.child('users/' + user.uid).set({
      'username': user.displayName,
      'email': user.email,
      'locality': place.locality,
      'postalCode': place.postalCode,
      'country': place.country
    });
    var userSignedIn = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => InitPage(user, _googleSignIn)));

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
      isLoading = false;
    });
  }
}
