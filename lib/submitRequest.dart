import 'package:flutter/material.dart';

class submitRequest extends StatefulWidget {
  const submitRequest({super.key});

  @override
  State<submitRequest> createState() => _submitRequestState();
}

class _submitRequestState extends State<submitRequest> {

  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _queryController = TextEditingController();
  final _pinCodeController = TextEditingController();

  String _gender = 'Male';
  String _country = 'India';
  String _citizenship = 'Indian';
  String? _ministry;
  String? _publicAuthority;

  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _queryController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RTI Request Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Text - Online RTI Request Form
                
                const Text(
                  'Online RTI Request Form',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Text - fields marked with * etc
                const Text(
                  'Note: Fields marked with * are Mandatory.',
                  style: TextStyle(color: Colors.red)),


                // Ministry Dropdown
                DropdownButtonFormField<String>(
                  value: _ministry,
                  decoration: InputDecoration(labelText: 'Select Ministry/Department/Apex Body'),
                  items: ['Ministry A', 'Ministry B', 'Ministry C']
                      .map((ministry) => DropdownMenuItem(value: ministry, child: Text(ministry)))
                      .toList(),
                  onChanged: (value) => setState(() => _ministry = value),
                  validator: (value) => value == null ? 'Please select a ministry' : null,
                ),

                // Public Authority Dropdown
                DropdownButtonFormField<String>(
                  value: _publicAuthority,
                  decoration: InputDecoration(labelText: 'Select Public Authority'),
                  items: ['Authority X', 'Authority Y', 'Authority Z']
                      .map((authority) => DropdownMenuItem(value: authority, child: Text(authority)))
                      .toList(),
                  onChanged: (value) => setState(() => _publicAuthority = value),
                  validator: (value) => value == null ? 'Please select a public authority' : null,
                ),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email-ID'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                // Confirm Email Field
                TextFormField(
                  controller: _confirmEmailController,
                  decoration: InputDecoration(labelText: 'Confirm Email-ID'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != _emailController.text) {
                      return 'Email does not match';
                    }
                    return null;
                  },
                ),

                // Phone Number Field
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}\$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                // Gender Radio Buttons
                Row(
                  children: [
                    Text('Gender: '),
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value.toString()),
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value.toString()),
                    ),
                    Text('Female'),
                    Radio(
                      value: 'Third Gender',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value.toString()),
                    ),
                    Text('Third Gender'),
                  ],
                ),

                // Address Field
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),

                // Pin Code Field
                TextFormField(
                  controller: _pinCodeController,
                  decoration: InputDecoration(labelText: 'Pin Code'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pin code';
                    }
                    if (!RegExp(r'^\d{6}\$').hasMatch(value)) {
                      return 'Please enter a valid 6-digit pin code';
                    }
                    return null;
                  },
                ),

                // Citizenship Dropdown
                DropdownButtonFormField<String>(
                  value: _citizenship,
                  decoration: InputDecoration(labelText: 'Citizenship'),
                  items: ['Indian', 'Other']
                      .map((citizen) => DropdownMenuItem(value: citizen, child: Text(citizen)))
                      .toList(),
                  onChanged: (value) => setState(() => _citizenship = value!),
                ),

                // RTI Query Field
                TextFormField(
                  controller: _queryController,
                  decoration: InputDecoration(labelText: 'RTI Request Application'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your RTI query';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit the form data
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Form Submitted'),
                            content: Text('Your RTI request has been submitted successfully!'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
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
