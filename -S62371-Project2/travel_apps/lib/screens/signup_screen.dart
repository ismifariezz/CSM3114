import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_apps/screens/home_screen.dart';
import 'dart:convert';
import 'package:travel_apps/widgets/my_textfield.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    try {
      if (_emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _usernameController.text.isEmpty) {
        // Show a snackbar or display an error message for empty fields
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields')),
        );
        return; // Exit the method if any field is empty
      }

      final url = Uri.https(
        'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'RegisteredUser.json',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': _emailController.text,
            'password': _passwordController.text,
            'username': _usernameController.text,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        print(response.body);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ));
      } else {
        print('Failed to register user');
        // Handle registration failure
        // Show a snackbar or display an error message
      }
    } catch (error) {
      print('Error during registration: $error');
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text('Sign Up',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B5998))),
            const SizedBox(height: 10),
            Text('Create your account'),
            const SizedBox(height: 30),
            MyTextField(
              controller: _usernameController,
              hintText: 'Username',
              obscureText: false,
              borderColor: Color(0xFF3B5998), // Border color for text field
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _emailController,
              hintText: 'your Email',
              obscureText: false,
              borderColor: Color(0xFF3B5998), // Border color for text field
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _passwordController,
              hintText: ' Your Password',
              obscureText: false,
              borderColor: Color(0xFF3B5998), // Border color for text field
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _signUp();
              },
              child: Container(
                padding: EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xFF3B5998), // Dark green button color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Color(0xFF3B5998)),
                ),
                const SizedBox(width: 2),
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final url = Uri.https(
        'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'RegisteredUser.json');

    final response = await http.get(url);
    final Map<String, dynamic> users = json.decode(response.body);
    String tempUser = "";
    // Check if the entered username and password match any user in the database
    final user = users.values.firstWhere(
      (user) {
        if (user['username'] == _usernameController.text &&
            user['password'] == _passwordController.text) {
          tempUser = _usernameController.text;
        }
        return (user['username'] == _usernameController.text &&
            user['password'] == _passwordController.text);
      },
      orElse: () => null,
    );

    if (user != null) {
      print('Sucesfully Login');
      // Successful login, navigate to home screen or desired screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return HomeScreen(username: tempUser);
        },
      ));
    } else if (_passwordController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      // Show a snackbar or display an error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return; // Exit the method if any field is empty
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account not registered')),
      );
      print('Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/start.png', // Replace with your actual image path
                  height: 120, // Set the height as needed
                ), // Dark green icon
                const SizedBox(height: 50),
                const Text(
                  'Welcome to Smart Travel Planner App',
                  style: TextStyle(color: Color(0xFF3B5998), fontSize: 16),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  obscureText: false,
                  borderColor:
                      const Color(0xFF3B5998), // Border color for text field
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  borderColor:
                      const Color(0xFF3B5998), // Border color for text field
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color(0xFF3B5998)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    _login();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B5998), // Dark green button color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: Color(0xFF3B5998)),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpPage();
                              },
                            ),
                          );
                        },
                        child: const Text('Register now'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
