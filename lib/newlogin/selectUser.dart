import 'package:capstone_focus/parentsManagement/parentMainScreen.dart';
import 'package:capstone_focus/screens/menu/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_focus/screens/hello.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Account App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: UserSelectionScreen(),
    );
  }
}

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;



    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/mainbg.png'),
                ),
                Text(
                  "Focus Finder",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "Choose User",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.all(20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [

                UserSelectionTile(
                  userType: 'Child',
                  onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen(userUID: user!.uid)));
                  },
                ),

                TextButton(
                  onPressed: () => _showPINModal(context, user?.uid),
                  child: Text(
                    "Parents",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Text color
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Round the corners
                    ),
                  ),
                )

                // Add more UserSelectionTile widgets for additional user types
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPINModal(BuildContext context, String? userUid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String errorMessage = ''; // Initialize an error message
        String enteredPin = '';

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Enter Parent PIN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PinEntryWidget(
                    userUid: userUid,
                    onPinChanged: (pin) {
                      setState(() {
                        enteredPin = pin;
                      });
                    },
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    String? pinEntered = await validatePIN(userUid);
                    print('PIN from Firebase: $pinEntered');
                    print('Entered PIN: $enteredPin');
                    if (pinEntered != null && pinEntered == enteredPin) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ParentMainScreen(),
                        ),
                      );
                    } else {
                      setState(() {
                        errorMessage = 'Incorrect PIN. Please try again.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Submit button background color
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String?> validatePIN(String? userUid) async {
    if (userUid == null) {
      return null;
    }

    try {
      String parentDocPath = '/users/$userUid/parents/password';
      DocumentSnapshot parentDoc = await FirebaseFirestore.instance.doc(parentDocPath).get();

      if (parentDoc.exists) {
        String pin = parentDoc['pin'].toString();
        print('PIN from Firebase: $pin'); // Print the PIN
        return pin;
      } else {
        return null;
      }
    } catch (e) {
      print('Error validating PIN: $e');
      return null;
    }
  }
}


class UserSelectionTile extends StatelessWidget {
  final String userType;
  final VoidCallback onPressed;

  UserSelectionTile({
    required this.userType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          var userData = snapshot.data!.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic> or null
          var avatarSelected = userData?['avatarSelected'];
          var userName = userData?['username'];

          if (avatarSelected != null) {
            return Card(
              color: Colors.white,
              elevation: 4, // Apply elevation for a material effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: onPressed,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(avatarSelected), // Load the user's avatar from assets
                      radius: 50, // You can adjust the size as needed
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        // Return a placeholder or a default image if the avatarSelected field is not available.
        return Card(
          elevation: 4, // Apply elevation for a material effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onPressed,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/default_avatar.png'), // Default avatar image
                  radius: 50, // You can adjust the size as needed
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




class PinEntryWidget extends StatefulWidget {
  final String? userUid;
  final ValueChanged<String> onPinChanged;

  PinEntryWidget({required this.userUid, required this.onPinChanged});

  @override
  _PinEntryWidgetState createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<PinEntryWidget> {
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  String enteredPin = '';

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (i < 3) {
                        _focusNodes[i + 1].requestFocus();
                      }
                      enteredPin += value;
                      if (enteredPin.length > 4) {
                        // Limit the PIN to 4 digits
                        enteredPin = enteredPin.substring(0, 4);
                      }
                    } else {
                      if (enteredPin.isNotEmpty) {
                        // Handle backspacing
                        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
                      }
                      if (i > 0) {
                        _focusNodes[i - 1].requestFocus();
                      }
                    }
                    widget.onPinChanged(enteredPin);
                  },
                  focusNode: _focusNodes[i],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
