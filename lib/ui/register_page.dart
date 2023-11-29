import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/database/sqlite.dart';
import 'package:flutter_ahlul_quran_app/ui/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';

import '../common/contants.dart';
import '../data/models/users_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isPasswordObscure = true;
  bool _isConfPasswordObscure = true;
  bool _isTermsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/login_hero.png'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: fullname,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Full name is required";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 15),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Fullname',
                                    labelStyle: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat ada kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat fokus dengan kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.sage300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: username,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*username is required";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 15),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Username',
                                    labelStyle: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat ada kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat fokus dengan kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.sage300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*password is required";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 15),
                                  obscureText: _isPasswordObscure,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat ada kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat fokus dengan kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.sage300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        // Mengubah visibilitas teks sandi
                                        setState(() {
                                          _isPasswordObscure =
                                              !_isPasswordObscure;
                                        });
                                      },
                                      child: Icon(
                                        _isPasswordObscure
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: confirmPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*Confirm password is required";
                                    } else if (password.text !=
                                        confirmPassword.text) {
                                      return "*Passwords don't match";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 15),
                                  obscureText: _isConfPasswordObscure,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Confirm Password',
                                    labelStyle: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat ada kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .red, // Atur warna border saat fokus dengan kesalahan
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.sage300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        // Mengubah visibilitas teks sandi
                                        setState(() {
                                          _isConfPasswordObscure =
                                              !_isConfPasswordObscure;
                                        });
                                      },
                                      child: Icon(
                                        _isConfPasswordObscure
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _isTermsChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          _isTermsChecked = value ?? false;
                                        });
                                      },
                                      activeColor: AppColors.sage300,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'I agree to the applicable ',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12)),
                                        children: const [
                                          TextSpan(
                                            text: '\nTerms of Service',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.sage300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      //Login method will be here

                                      final db =
                                          DatabaseHelper(); //enkripsi password
                                      var bytes = utf8.encode(password
                                          .text); // Ubah string password menjadi bytes
                                      var hashedPassword = sha256
                                          .convert(bytes)
                                          .toString(); // Enkripsi password menggunakan SHA-256

                                      print('Username: ${fullname.text}');
                                      print('Username: ${username.text}');
                                      print('Password: ${password.text}');
                                      print(
                                          'Confirm Password: ${confirmPassword.text}');
                                      print('Hashed Password: $hashedPassword');

                                      db
                                          .signup(Users(
                                              fullName: fullname.text,
                                              usrName: username.text,
                                              usrPassword: hashedPassword))
                                          .whenComplete(() {
                                        //After success user creation go to login screen
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.sage300,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Radius sudut tombol
                                    ),
                                    elevation: 0,
                                    minimumSize: const Size(370, 44),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
