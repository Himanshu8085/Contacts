import 'package:flutter/material.dart';
import 'Addcontact.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class Dashboard extends StatefulWidget {
  String b = '';
  Dashboard(String a) {
    b = a;
  }

  @override
  State<Dashboard> createState() {
    return _DashboardState(dbname: b);
  }
}

class _DashboardState extends State<Dashboard> {
  final String dbname;
  String usr = '';

  _DashboardState({required this.dbname});

  Future<void> fetchAndSetFullName(String dbName) async {
    Database database = await createDatabase(dbName);
    List<Map<String, dynamic>> rows = await database.query('your_table');

    String fullName = '';
    for (var row in rows) {
      String prefix = row['usr_prefix'] ?? '';
      String firstName = row['usr_first_name'] ?? '';
      String middleName = row['usr_middle_name'] ?? '';
      String lastName = row['usr_last_name'] ?? '';

      String fullNameRow = '$prefix $firstName $middleName $lastName';
      fullName += fullNameRow + '\n'; // Add a new line for each full name
    }

    setState(() {
      usr = fullName.trim();
      // Trim any leading or trailing whitespace
    });
    await database.close();
  }

  Future<void> _initializeData() async {
    await fetchAndSetFullName(
        dbname); // Wait for fetchAndSetFullName to complete
    setState(() {}); // Trigger rebuild to reflect updated data
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    print(usr);
    print(dbname);
    if (usr == '') {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ContactManagerDashboard(usr, dbname);
    }
  }
}

class User {
  final String prefix;
  final String firstName;
  final String middleName;
  final String lastName;
  final String countryCode;
  final String mobileNumber;
  final String email;
  final String gender;
  final String dateOfBirth;

  User({
    required this.prefix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
  });
}

class Contact {
  final String prefix;
  final String firstName;
  final String middleName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String address;

  Contact({
    required this.prefix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
  });
}

class ContactManagerDashboard extends StatefulWidget {
  String userName = '';
  String dbname = '';
  ContactManagerDashboard(String usr, String db) {
    userName = usr;
    dbname = db;
  }

  @override
  State<ContactManagerDashboard> createState() =>
      _ContactManagerDashboardState(userName, dbname);
}

class _ContactManagerDashboardState extends State<ContactManagerDashboard> {
  String userName = '';
  String dbname = '';
  _ContactManagerDashboardState(String usr, String db) {
    userName = usr;
    dbname = db;
  }
  List<Contact> contacts = [];

//hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

  String usr = '';
  Future<void> fetchAndSetFullName(String dbName) async {
    Database database = await createDatabase(dbName);
    List<Map<String, dynamic>> rows = await database.query('your_table');

    String fullName = '';
    for (var row in rows) {
      String prefix = row['Prefix'] ?? '';
      String firstName = row['first_name'] ?? '';
      String middleName = row['Middle_name'] ?? '';
      String lastName = row['Last_name'] ?? '';
      String mobileno = row['Mobile_number'] ?? '';
      String email = row['Email_ID'] ?? '';
      String dob = row['Date_of_birth'] ?? '';
      String gen = row['Gender'] ?? '';
      String add = row['Address'] ?? '';

      // DateTime DOB = DateTime(1);

      contacts.add(Contact(
        prefix: prefix,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        mobileNumber: mobileno,
        email: email,
        gender: gen,
        dateOfBirth: dob,
        address: add,
      ));

      String fullNameRow =
          '$prefix $firstName $middleName $lastName$mobileno$email$dob$gen$add';
      fullName += fullNameRow + '\n'; // Add a new line for each full name
    }

    setState(() {
      usr = fullName.trim();
      // Trim any leading or trailing whitespace
      print("gggggggggggggg " + usr);
    });
    await database.close();
  }

  Future<void> _initializeData() async {
    await fetchAndSetFullName(
        dbname); // Wait for fetchAndSetFullName to complete
    setState(() {}); // Trigger rebuild to reflect updated data
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

//hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Welcome $userName', style: TextStyle(fontSize: 20)),
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${contact.prefix} ${contact.firstName} ${contact.middleName} ${contact.lastName}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(contact.mobileNumber, style: TextStyle(fontSize: 16)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactDetailsScreen(contact: contact),
                    ),
                  );
                },
              ),
            );
          },
        ),
        // Add Contact
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContact(dbname)),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  ContactDetailsScreen({required this.contact});
  String mobilenodb = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem('Prefix', contact.prefix),
              _buildDetailItem('First Name', contact.firstName),
              _buildDetailItem('Middle Name', contact.middleName),
              _buildDetailItem('Last Name', contact.lastName),
              _buildDetailItem('Mobile Number', contact.mobileNumber),
              _buildDetailItem('Email ID', contact.email),
              _buildDetailItem('Date of Birth', contact.dateOfBirth.toString()),
              _buildDetailItem('Gender', contact.gender),
              _buildDetailItem('Address', contact.address),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
