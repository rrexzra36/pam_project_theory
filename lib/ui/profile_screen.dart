import 'package:flutter_ahlul_quran_app/ui/editprofil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:flutter_ahlul_quran_app/ui/login_page.dart';
import 'package:flutter_ahlul_quran_app/ui/payment_page.dart';
import 'package:flutter_ahlul_quran_app/ui/premium_page.dart';
import 'package:flutter_ahlul_quran_app/ui/testimonials_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyHomePage(), // Navigate to your HomePage
            ),
          );
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Profile Page",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: AppColors.sage300,
            elevation: 0,
          ),
          backgroundColor: AppColors.deen,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: height / 4,
                  decoration: const BoxDecoration(
                      color: AppColors.sage300,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: width / 20,
                        right: width / 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Align(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height / 15, bottom: height / 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:
                                          const AssetImage('assets/ezra.jpg'),
                                      radius: height / 10,
                                    ),
                                    SizedBox(
                                      height: height / 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Reyhan Ezra',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 18.0,
                                              color: AppColors.sage300,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/premium-badge.svg',
                                          color: Color(0xffFFB000),
                                          width: 24,
                                          height: 24,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment
                                      .centerLeft, // Atur perataan ke kiri
                                  child: Text(
                                    'GENERAL',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Color(0xff858DA0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditProfile(),
                                      ),
                                    );
                                  },
                                  child: infoChild(
                                      Icons.account_box,
                                      'Profile Settings',
                                      'Update and modify your profile'),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PremiumPage(),
                                      ),
                                    );
                                  },
                                  child: infoChild(
                                      Icons.workspace_premium_outlined,
                                      'Get Premium',
                                      'Subcribe to get more features'),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PaymentHistory(),
                                      ),
                                    );
                                  },
                                  child: infoChild(
                                      Icons.history_edu_outlined,
                                      'Payment History',
                                      'Check your payment history'),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Testimonials(),
                                      ),
                                    );
                                  },
                                  child: infoChild(
                                      Icons.note_alt_rounded,
                                      'Testimonials',
                                      'See my impressions and suggestions'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height / 30, bottom: height / 30),
                                  child: InkWell(
                                    onTap: () {
                                      showLogoutConfirmation(context);
                                    },
                                    child: Container(
                                      width: width / 3,
                                      height: height / 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Log Out',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget infoChild(IconData icon, String judul, String subjudul) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.sage, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 35,
              color: AppColors.sage300,
            ),
          ),
          title: Text(
            judul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.sage300,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            subjudul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: AppColors.black,
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ),
      );
}

showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Logout Confirmation',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 100,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: AppColors.sage300)),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: AppColors.sage300,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
    },
  );
}
