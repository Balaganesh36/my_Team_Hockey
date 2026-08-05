// join_club_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinClubPage extends StatefulWidget {
  @override
  _JoinClubPageState createState() => _JoinClubPageState();
}

class _JoinClubPageState extends State<JoinClubPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _positionController = TextEditingController();
  final _contactController = TextEditingController();

  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _positionController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Simulate successful submission
      setState(() {
        _isSubmitted = true;
      });

      // Optional: Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Application submitted successfully!"),
          duration: Duration(seconds: 3),
        ),
      );

      // Reset form after submission (optional)
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isSubmitted = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join PPG Hockey Club"),
        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isSubmitted
              ? _buildSuccessScreen() // Show success message
              : _buildForm(), // Show form
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Text(
            "Join My Team Hockey",
            style: GoogleFonts.oldenburg(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Fill out the form below to apply for membership. We'll get back to you soon!",
            style: GoogleFonts.oldStandardTt(
              color: Colors.white70,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),

          // Name Field
          TextFormField(
            controller: _nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Full Name",
              labelStyle: TextStyle(color: Colors.white70),
              hintText: "Enter your full name",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Age Field
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Age",
              labelStyle: TextStyle(color: Colors.white70),
              hintText: "e.g. 20",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
              ),
              prefixIcon: Icon(Icons.calendar_today, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              if (int.tryParse(value) == null) {
                return 'Enter a valid number';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Position Field
          TextFormField(
            controller: _positionController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Preferred Position",
              labelStyle: TextStyle(color: Colors.white70),
              hintText: "e.g. Forward, Goalkeeper",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
              ),
              prefixIcon: Icon(Icons.sports_hockey, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your preferred position';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Contact Field
          TextFormField(
            controller: _contactController,
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(color: Colors.white70),
              hintText: "+91 XXXXXXXXXX",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
              ),
              prefixIcon: Icon(Icons.phone, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!value.startsWith('+91') && value.length != 10) {
                return 'Enter a valid Indian phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 30),

          // Submit Button
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Submit Application",
              style: GoogleFonts.oldenburg(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 80),
          SizedBox(height: 20),
          Text(
            "Application Submitted!",
            style: GoogleFonts.oldenburg(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Thank you, ${_nameController.text}! We’ve received your application. Our coach will contact you soon.",
            style: GoogleFonts.oldStandardTt(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text("Back to Home", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
