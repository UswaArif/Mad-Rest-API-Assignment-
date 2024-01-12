import 'package:assignment/pages/cutomer_home_page.dart';
import 'package:assignment/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false; // Define and initialize isLoading as false
  bool _passwordVisible = false; // Initially, the password is hidden
  
  
  @override
  Future<void> _login() async {
    final String email = _email.text;
    final String password = _password.text;

    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'), 
      body: {
        'email': email,
        'password': password,
      },
      
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print("Login successfully");
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;    
    return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("My AirLine", style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.deepPurple),),
              Text("Welcome Back", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.deepPurpleAccent),),
              Form(
                key: _formKey,
              child: OverflowBar(
                overflowSpacing: 20,
                children: [
                  TextFormField(
                    controller: _email,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'Email is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: "Email",
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Password is empty';
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible, 
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.fingerprint),
                      labelText: "Password",
                      hintText: "Enter your Password",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible; // Toggle _passwordVisible
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  
                  
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: ()async{
                        if (_formKey.currentState!.validate()){                          
                          _login();                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomerHomePage()), 
                          );                         
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), 
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                     
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()), 
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an Account? ",
                              style: TextStyle(
                                color: Colors.black, 
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.deepPurple, // Set the color of the "Sign Up" portion
                                decoration: TextDecoration.underline, // Underline the "Sign Up" text
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                ],
                
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

// {
//     "email": "eve.holt@reqres.in",
//     "password": "cityslicka"
// }
