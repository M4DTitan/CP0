import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile information
  Future<void> _fetchUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('usuarios').doc(user.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          _institutionController.text = userData['institution'] ?? '';
          _fieldOfStudyController.text = userData['fieldOfStudy'] ?? '';
          _cityController.text = userData['city'] ?? '';
          _ageController.text = userData['age'] ?? '';
          _bioController.text = userData['bio'] ?? '';
        }
      }
    } catch (e) {
      print('Error fetching profile information: $e');
    }
  }

  // Update user profile information
  Future<void> _updateUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('usuarios').doc(user.uid).set({
          'institution': _institutionController.text,
          'fieldOfStudy': _fieldOfStudyController.text,
          'city': _cityController.text,
          'age': _ageController.text,
          'bio': _bioController.text,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error updating profile information: $e');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Profile'),
      backgroundColor: Color(0xFF120F42), // Deep Blue
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(_institutionController, 'Institution'),
          SizedBox(height: 12.0),
          _buildTextField(_fieldOfStudyController, 'Field of Study'),
          SizedBox(height: 12.0),
          _buildTextField(_cityController, 'City'),
          SizedBox(height: 12.0),
          _buildTextField(_ageController, 'Age'),
          SizedBox(height: 12.0),
          _buildTextField(_bioController, 'Bio (max. 250 characters)', maxLines: 4),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _updateUserProfile,
            child: Text('Save Changes'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF3C34E0), // Purple
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTextField(TextEditingController controller, String label,
    {int? maxLines}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    maxLines: maxLines,
  );
}


  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String labelText, {int? maxLines}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      maxLines: maxLines ?? 1,
    );
  }
}
