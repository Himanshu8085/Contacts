import 'package:flutter/material.dart';
import 'login_registor.dart';

// Main run function
void main() {
  runApp(OnboardingApp());
}

// onbording screen
class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

// Container for OnboardingPage Widgets
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final PageController _pageController = PageController();
int countclicks = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // page view to contain onboarding page widgets
      body: PageView(
        controller: _pageController,
        children: [
          OnboardingPage(
            title: 'Welcome to Contacts',
            description:
                'Welcome to our Contacts app! Simplify your life by organizing all your contacts in one place. Connect, communicate, and collaborate effortlessly.',
            imageUrl: 'assets/one.PNG',
          ),
          OnboardingPage(
            title: 'Effortless Management',
            description:
                'Effortlessly manage your contacts with our intuitive app. From adding new contacts to updating details, our app streamlines the process, making it a breeze to stay connected.',
            imageUrl: 'assets/two.PNG',
          ),
          OnboardingPage(
            title: 'Secure Login',
            description:
                'Your security is our top priority. With our robust authentication system, your login credentials are kept safe and secure. Sign in with confidence and enjoy peace of mind.',
            imageUrl: 'assets/three.PNG',
          ),
          OnboardingPage(
            title: 'Stay Connected Anywhere',
            description:
                'Stay connected wherever you go. Our app syncs seamlessly across devices, ensuring that your contacts are always up-to-date and accessible whenever you need them.',
            imageUrl: 'assets/four.PNG',
          )
        ],
      ),
      // Button for next page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              "$countclicks"); // prints how many times button isclicked on console
          if (countclicks == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LR()),
            ); // Load Screen for login and registritation
          }
          _pageController.nextPage(
            duration: Duration(milliseconds: 500), // Animation time
            curve: Curves.ease,
          );
          countclicks++;
        },
        child: Icon(Icons.arrow_forward), // Button icon for next screen
      ),
    );
  }
}

// This is the skeleton of onboarding page
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
