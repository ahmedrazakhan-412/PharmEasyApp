import 'package:flutter/material.dart';
import 'InputDecoration.dart';
import 'package:medicalstore/PageWise/CustomerManagementScreen/CustomerManagementScreen.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';
  String _password = '';
  String _confirmPassword = '';
  String _gender = '';
  String _ageGroup = '';
  String _preferredLanguage = '';
  List<String> _interests = [];
  DateTime _dob = DateTime.now();

  void _showCongratulatoryDialog(String? name) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Congratulations!\n$name',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Registration Successful.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerManagementScreen()),
                );// Navigate to main.dart
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, process the registration data
      // You can perform API requests or any other operations here
      // using the collected data.
      // For demonstration, we print the data to the console.
      print('Name: $_name');
      print('Email: $_email');
      print('Phone Number: $_phoneNumber');
      print('Address: $_address');
      print('Password: $_password');
      print('Confirm Password: $_confirmPassword');
      print('Gender: $_gender');
      print('Age Group: $_ageGroup');
      print('Preferred Language: $_preferredLanguage');
      print('Interests: $_interests');
      print('Date of Birth: $_dob');

      // Optionally, you can clear the form fields after submission
      _formKey.currentState?.reset();
      setState(() {
        _interests = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Customer Registration Form'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: buildInputDecoration(Icons.person,'Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: buildInputDecoration(Icons.email,'Email'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    // Additional email validation logic can be implemented here
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: buildInputDecoration(Icons.phone,'Phone Number'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    // Additional phone number validation logic can be implemented here
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber = value!;
                  },
                ),
                TextFormField(
                  decoration: buildInputDecoration(Icons.location_on,'Address'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value!;
                  },
                ),
                TextFormField(
                  decoration: buildInputDecoration(Icons.lock,'Password'),
                  obscureText: true,
                   validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                TextFormField(
                  decoration: buildInputDecoration(Icons.lock,'Confirm Password' ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please confirm your password';
                    }
                    if (value == _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _confirmPassword = value!;
                  },
                ),
                ListTile(
                  title: Text(
                    'Gender',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    _gender,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.people),
                  onTap: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Select Gender'),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Male');
                              },
                              child: Text('Male'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Female');
                              },
                              child: Text('Female'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Other');
                              },
                              child: Text('Other'),
                            ),
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      setState(() {
                        _gender = result;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'Age Group',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    _ageGroup,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.calendar_today),
                  onTap: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Select Age Group'),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '18-24');
                              },
                              child: Text('18-24'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '25-34');
                              },
                              child: Text('25-34'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '35-44');
                              },
                              child: Text('35-44'),
                            ),
                             SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '45-74');
                              },
                              child: Text('45-74'),
                            ),
                            // Additional age group options can be added here
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      setState(() {
                        _ageGroup = result;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'Preferred Language',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    _preferredLanguage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.language),
                  onTap: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Select Preferred Language'),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'English');
                              },
                              child: Text('English'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Hindi');
                              },
                              child: Text('Hindi'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Kannada');
                              },
                              child: Text('Kannada'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Tamil');
                              },
                              child: Text('Tamil'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 'Bengali');
                              },
                              child: Text('Bengali'),
                            ),
                            // Additional language options can be added here
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      setState(() {
                        _preferredLanguage = result;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'Interests',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    _interests.join(', '),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.star),
                  onTap: () async {
                    final result = await showDialog<List<String>>(
                      context: context,
                      builder: (BuildContext context) {
                        List<String> selectedInterests = List.from(_interests);
                        return AlertDialog(
                          title: Text('Select Interests'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                CheckboxListTile(
                                  title: Text('Sports'),
                                  value: selectedInterests.contains('Sports'),
                                  onChanged: (value) {
                                    if (value!) {
                                      selectedInterests.add('Sports');
                                    } else {
                                      selectedInterests.remove('Sports');
                                    }
                                    setState(() {
                                      _interests = List.from(selectedInterests);
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text('Music'),
                                  value: selectedInterests.contains('Music'),
                                  onChanged: (value) {
                                    if (value!) {
                                      selectedInterests.add('Music');
                                    } else {
                                      selectedInterests.remove('Music');
                                    }
                                    setState(() {
                                      _interests = List.from(selectedInterests);
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text('Travel'),
                                  value: selectedInterests.contains('Travel'),
                                  onChanged: (value) {
                                    if (value!) {
                                      selectedInterests.add('Travel');
                                    } else {
                                      selectedInterests.remove('Travel');
                                    }
                                    setState(() {
                                      _interests = List.from(selectedInterests);
                                    });
                                  },
                                ),
                                // Additional interest options can be added here
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, selectedInterests);
                              },
                              child: Text('Done'),
                            ),
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      setState(() {
                        _interests = result;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    _dob != null ? _dob.toString() : '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.date_range),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _dob = selectedDate;
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                     if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        print("Successful");
                        _showCongratulatoryDialog(_name);
                      } else {
                        print("Unsuccessful");
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
