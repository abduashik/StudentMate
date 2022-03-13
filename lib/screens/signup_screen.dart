import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_mate/resources/auth_methods.dart';
import 'package:students_mate/responsive/mobile_screen_layout.dart';
import 'package:students_mate/responsive/responsive_screen_layout.dart';
import 'package:students_mate/responsive/web_screen_layout.dart';
import 'package:students_mate/screens/login_screen.dart';
import 'package:students_mate/utils/colors.dart';
import 'package:students_mate/widgets/text_field_input.dart';
import 'package:students_mate/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactnumController = TextEditingController();
  final TextEditingController _uprnController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signupUser(
        uprn: _uprnController.text,
        name: _nameController.text,
        email: _emailController.text,
        contactnum: _contactnumController.text,
        dept: selectedValue,
        password: _passwordController.text,
        file: _image!);

    setState(() {
      _isloading = false;
    });
    if (res == "Success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactnumController.dispose();
    _uprnController.dispose();
    _deptController.dispose();
    _nameController.dispose();
  }

  List<DropdownMenuItem<String>> get dropdownItems {

    List<DropdownMenuItem<String>> menuItems =[
      DropdownMenuItem(child: Text('cs'), value: "computer science"),
    ];
    return menuItems;
  }

  String selectedValue = "computer science";

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 8,
              ),
              //svg image
              SvgPicture.asset(
                'assets/user-login-305.svg',
                // color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 30),
              // circular
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 54,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 54,
                          backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/vectors/male-profile-flat-blue-simple-icon-with-long-shadow-vector-id522855255?k=20&m=522855255&s=612x612&w=0&h=fLLvwEbgOmSzk1_jQ0MgDATEVcVOh_kqEe0rqi7aM5A='),
                        ),
                  Positioned(
                    bottom: -9,
                    left: 67,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // UPRN text field
              TextFieldInput(
                  textEditingController: _uprnController,
                  hintText: 'Enter your UPRN',
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              // name
              TextFieldInput(
                  textEditingController: _nameController,
                  hintText: 'Enter your name',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              // email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              // contactnum
              TextFieldInput(
                  textEditingController: _contactnumController,
                  hintText: 'Enter your contact number',
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              // dept
              // TextFieldInput(
              //     textEditingController: _deptController,
              //     hintText: 'Enter your department',
              //     textInputType: TextInputType.text),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  dropdownColor: Colors.white,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
              const SizedBox(
                height: 20,
              ),
              // password
              // TextFieldInput(
              //   textEditingController: _passwordController,
              //   hintText: 'Enter your password',
              //   textInputType: TextInputType.text,
              //   isPass: true,
              // ),
              const SizedBox(
                height: 20,
              ),
              // button for signup
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isloading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : const Text('Sign In'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // transitioning to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
