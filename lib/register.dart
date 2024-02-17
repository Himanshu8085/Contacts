import 'package:flutter/material.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController prefixController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  String a = 'usr_prefix';
  String b = 'usr_first_name';
  String c = 'usr_middle_name';
  String d = 'usr_last_name';
  String e = 'usr_country_code';
  String f = 'usr_first_name';
  String g = 'usr_middle_name';
  String h = 'usr_last_name';
  String i = 'usr_country_code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Registration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Builder(
            builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  // Prefix
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Prefix*'),
                    controller: prefixController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your prefix';
                      }
                      return null;
                    },
                  ),
                  // 1st name
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name*'),
                    controller: firstNameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  // middle name
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Middle Name'),
                    controller: middleNameController,
                  ),
                  // last name
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name*'),
                    controller: lastNameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  // country code
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Country Code*'),
                    controller: countryCodeController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your country code';
                      }
                      return null;
                    },
                  ),
                  // mobile no
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mobile Number*'),
                    controller: mobileNumberController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  // email
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email ID'),
                    controller: emailController,
                  ),
                  // gender
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Gender*'),
                    controller: genderController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your gender';
                      }
                      return null;
                    },
                  ),
                  // DOB
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Date of Birth*'),
                    controller: dateOfBirthController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final FormState? formState = _formKey.currentState;
                      if (formState != null && formState.validate()) {
                        // Process the data
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('User Registered Sucessfully')),
                        );
                        // Ceate db with name mobile no as id
                        Database database1 =
                            await createDatabase(mobileNumberController.text);

                        a = prefixController.text;
                        b = firstNameController.text;
                        c = middleNameController.text;
                        d = lastNameController.text;
                        e = countryCodeController.text;
                        f = mobileNumberController.text;
                        g = emailController.text;
                        h = genderController.text;
                        i = dateOfBirthController.text;

                        _insertData(database1);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Inserting data in db
  void _insertData(Database database) async {
    Map<String, dynamic> data = {
      'usr_prefix': a,
      'usr_first_name': b,
      'usr_middle_name': c,
      'usr_last_name': d,
      'usr_country_code': e,
      'usr_mobile_number': f,
      'usr_email': g,
      'usr_gender': h,
      'usr_date_of_birth': i,
    };

    await insertData(database, data);
  }
}
