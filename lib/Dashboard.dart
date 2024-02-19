import 'package:flutter/material.dart';
import 'Addcontact.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ContactManagerDashboard(userName: 'John Doe');
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
  final DateTime dateOfBirth;

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
  final DateTime dateOfBirth;
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

class ContactManagerDashboard extends StatelessWidget {
  final String userName;
  final List<Contact> contacts = [
    Contact(
      prefix: 'Mr.',
      firstName: 'John',
      middleName: '',
      lastName: 'Doe',
      mobileNumber: '+1234567890',
      email: 'john.doe@example.com',
      gender: 'Male',
      dateOfBirth: DateTime(1985, 10, 15),
      address: '123 Main St, Anytown, USA',
    ),
    Contact(
      prefix: 'Mrs.',
      firstName: 'Jane',
      middleName: '',
      lastName: 'Smith',
      mobileNumber: '+1987654321',
      email: 'jane.smith@example.com',
      gender: 'Female',
      dateOfBirth: DateTime(1990, 5, 20),
      address: '456 Elm St, Othertown, USA',
    ),
    // Add more contacts here...
  ];

  ContactManagerDashboard({required this.userName});

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
            // Add your onPressed functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContact()),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailsScreen({required this.contact});

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
