import 'dart:async';

import 'package:contacts_manager_v1_task_2/Maps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'database.dart';

class AddContact extends StatefulWidget {
  String a = '';
  AddContact(String s) {
    a = s;
  }
  @override
  _AddContactState createState() => _AddContactState(a);
}

class _AddContactState extends State<AddContact> {
  String mobilenodb = '';
  _AddContactState(String a) {
    mobilenodb = a;
  }
  String? _selectedPrefix;
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _mobileNumber = '';
  String _email = '';
  DateTime _selectedDateOfBirth = DateTime.now();
  String? _selectedGender;
  String _address = '';

  final _formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildFormField(
                labelText: 'Prefix',
                onSaved: (value) => _selectedPrefix = value,
              ),
              _buildFormField(
                labelText: 'First Name',
                onSaved: (value) => _firstName = value!,
              ),
              _buildFormField(
                labelText: 'Middle Name',
                onSaved: (value) => _middleName = value!,
              ),
              _buildFormField(
                labelText: 'Last Name',
                onSaved: (value) => _lastName = value!,
              ),
              _buildFormField(
                labelText: 'Mobile Number',
                onSaved: (value) => _mobileNumber = value!,
                keyboardType: TextInputType.phone,
              ),
              _buildFormField(
                labelText: 'Email ID',
                onSaved: (value) => _email = value!,
                keyboardType: TextInputType.emailAddress,
              ),
              ListTile(
                title: Text('Date of Birth'),
                subtitle:
                    Text('${_selectedDateOfBirth.toLocal()}'.split(' ')[0]),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _selectedDateOfBirth) {
                    setState(() {
                      _selectedDateOfBirth = picked;
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              // _buildAddressField(),
              address(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget address() {
    LatLng pos = LatLng(0, 0);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Enter Address'),
            controller: _addressController,
          ),
        ),
        IconButton(
          icon: Icon(Icons.place),
          onPressed: () async {
            pos = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Maps(),
              ),
            );

            double a = pos.latitude;
            double b = pos.longitude;
            print("$a and $b"); // returned coordinates
            List<Placemark> placemarks = await placemarkFromCoordinates(a, b);
            _addressController.text = placemarks.first.toString();
            print(_addressController.text);
          },
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String labelText,
    required void Function(String?) onSaved,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      onSaved: onSaved,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

// Enter/Save button
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Update _address variable with the value from _addressController
      _address = _addressController.text;

      // Form is validated, save the data or perform any other action here
      // Print the data after it has been updated
      print('Prefix: $_selectedPrefix');
      print('First Name: $_firstName');
      print('Middle Name: $_middleName');
      print('Last Name: $_lastName');
      print('Mobile Number: $_mobileNumber');
      print('Email: $_email');
      print('Date of Birth: $_selectedDateOfBirth');
      print('Gender: $_selectedGender');
      print('Address: $_address');
      _insertData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contact Saved sucessfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please chek the form')),
      );
    }
  }

  void _insertData() async {
    Map<String, dynamic> newData = {
      'Prefix': _selectedPrefix.toString(),
      'first_name': _firstName.toString(),
      'Middle_name': _middleName.toString(),
      'Last_name': _lastName.toString(),
      'Mobile_number': _mobileNumber.toString(),
      'Email_ID': _email.toString(),
      'Date_of_birth': _selectedDateOfBirth.toString(),
      'Gender': _selectedGender.toString(),
      'Address': _address.toString()
      // Add more key-value pairs for other columns as needed
    };

    await insertdata(mobilenodb, newData);
  }
}
