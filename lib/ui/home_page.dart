import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ahlul_quran_app/ui/profile_screen.dart';
import 'package:flutter_ahlul_quran_app/ui/shalat_schedule.dart';
import 'package:flutter_ahlul_quran_app/ui/surat_page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/contants.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> quotes = [
  "Sebaik - baik manusia diantara kamu adalah yang mempelajari Al-Quran dan mengajarkannya (HR Bukhori)",
  "Barangsiapa membaca satu huruf dari Kitab Allah, maka baginya satu kebaikan, dan satu kebaikan itu dilipatgandakan (HR Trimidzi)",
  "Barangsiapa membaca Al-Quran, maka ia akan mendapatkan pahala yang besar (HR Ibnu Majah)",
  ]; // Teks yang akan diganti
  int currentQuoteIndex = 0;

  @override
  void initState() {
    super.initState();
    // Memulai timer untuk mengganti teks setiap 5 detik
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Confirmation',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Text(
                'Are you sure you want to quit?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
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
                        onPressed: () => Navigator.of(context).pop(false),
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
                        onPressed: () => SystemNavigator.pop(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.sage300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Quit',
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
        return value ?? false; // default: tidak keluar dari aplikasi
      },
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Sacred Quran',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.sage100,
          image: DecorationImage(
            image: AssetImage('assets/latar_home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.sp,
          vertical: 16.sp,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 156.h,
              width: size.width - 24.w - 24.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 16.sp,
                    child: Container(
                      height: 140.h,
                      width: size.width - 24.w - 24.w,
                      decoration: BoxDecoration(
                        color: AppColors.sage300,
                        borderRadius: BorderRadius.circular(18.r),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/motivasi.png'),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.sp),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  color: AppColors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  'Motivasi',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(seconds: 1), // Durasi animasi
                              child: Text(
                                quotes[currentQuoteIndex], // Mengganti teks sesuai indeks saat ini
                                key: ValueKey<int>(currentQuoteIndex),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 24.sp,
                    child: SizedBox(
                      width: 40.w,
                      height: 32.h,
                      child: SvgPicture.asset('assets/svg/petik_sage.svg', color: AppColors.beige),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SuratPage();
                        }));
                      },
                      child: Container(
                        width: (size.width - 24.sp - 24.sp - 20.sp) / 2,
                        height: 186.h,
                        decoration: BoxDecoration(
                          color: AppColors.sage300,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColors.sage300,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.sp,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 24.sp),
                                    child: SvgPicture.asset(
                                      'assets/svg/book.svg',
                                      fit: BoxFit.fitHeight,
                                      color: AppColors.white,
                                      height: 52.h,
                                      width: 44.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 24.sp),
                                    child: Text(
                                      'Al Quran',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: -4.sp,
                                left: 76.sp,
                                child: SizedBox(
                                  width: 160.w,
                                  height: 160.h,
                                  child:
                                      SvgPicture.asset('assets/svg/ornament.svg'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return ShalatSchedule();
                            }));
                      },
                      child: Container(
                        width: (size.width - 24.sp - 24.sp - 20.sp) / 2,
                        height: 155.h,
                        decoration: BoxDecoration(
                          color: AppColors.sage,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColors.sage300.withOpacity(0.3),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.sp,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 24.sp),
                                    child: SvgPicture.asset(
                                      'assets/svg/bookmark.svg',
                                      fit: BoxFit.fitHeight,
                                      color: AppColors.sage300,
                                      height: 52.h,
                                      width: 44.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 24.sp),
                                    child: Text(
                                      'Bookmark',
                                      style: TextStyle(
                                        color: AppColors.sage300,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: -4.sp,
                                left: 60.sp,
                                child: SizedBox(
                                  width: 160.w,
                                  height: 160.h,
                                  child: SvgPicture.asset('assets/svg/ornament.svg',
                                      color: AppColors.sage100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const ProfilePage();
                            }));
                      },
                      child: Container(
                        width: (size.width - 24.sp - 24.sp - 20.sp) / 2,
                        height: 155.h,
                        decoration: BoxDecoration(
                          color: AppColors.sage,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColors.sage300.withOpacity(0.3),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.sp,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 24.sp),
                                    child: SvgPicture.asset(
                                      'assets/svg/brain.svg',
                                      fit: BoxFit.fitHeight,
                                      color: AppColors.sage300,
                                      height: 52.h,
                                      width: 44.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 24.sp),
                                    child: Text(
                                      'Hafalan',
                                      style: TextStyle(
                                        color: AppColors.sage300,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: -4.sp,
                                left: 60.sp,
                                child: SizedBox(
                                  width: 160.w,
                                  height: 160.h,
                                  child: SvgPicture.asset('assets/svg/ornament.svg',
                                      color: AppColors.sage100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: (size.width - 24.sp - 24.sp - 20.sp) / 2,
                      height: 186.h,
                      decoration: BoxDecoration(
                        color: AppColors.sage300,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: AppColors.sage300,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.sp,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return ShalatSchedule();
                                }));
                          },
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 24.sp),
                                    child: SvgPicture.asset(
                                      'assets/svg/mosque.svg',
                                      fit: BoxFit.fitHeight,
                                      color: AppColors.white,
                                      height: 52.h,
                                      width: 44.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 24.sp),
                                    child: Text(
                                      'Jadwal Sholat',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: -4.sp,
                                left: 76.sp,
                                child: SizedBox(
                                  width: 160.w,
                                  height: 160.h,
                                  child: SvgPicture.asset('assets/svg/ornament.svg'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
