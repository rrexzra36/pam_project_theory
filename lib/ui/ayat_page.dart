import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_ahlul_quran_app/bloc/ayat/ayat_bloc.dart';
import 'package:flutter_ahlul_quran_app/data/models/surat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/contants.dart';
import '../data/models/surat_favorite_model.dart';
import '../database/sqlite.dart';

class AyatPage extends StatefulWidget {
  const AyatPage({
    Key? key,
    required this.surat,
  }) : super(key: key);
  final SuratModel surat;

  @override
  State<AyatPage> createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  final db = DatabaseHelper();
  late SharedPreferences _logindata;
  late int usrId;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      usrId = _logindata.getInt('userId')!;
    });
    context.read<AyatBloc>().add(AyatGetEvent(noSurat: widget.surat.nomor));
  }

  String _getSentenceCase(TempatTurun tempatTurun) {
    String tempatTurunString = tempatTurun.toString().split('.').last;
    tempatTurunString = tempatTurunString[0].toUpperCase() +
        tempatTurunString.substring(1).toLowerCase();
    return tempatTurunString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.surat.namaLatin,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.sage300,
          ),
        ),
        backgroundColor: AppColors.deen,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.sage300,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_add_outlined),
            onPressed: () {
              final nomorSurat = widget.surat.nomor.toString();
              final namaSurat = widget.surat.namaLatin;
              final jumlahAyat = widget.surat.jumlahAyat.toString();
              db.insertFavorite(usrId, nomorSurat, namaSurat, jumlahAyat);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Surat berhasil ditambahkan ke favorit'),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.spatial_audio_off),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: AppColors.deen,
      body: BlocBuilder<AyatBloc, AyatState>(
        builder: (context, state) {
          if (state is AyatLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(color: AppColors.sage300),
                  SizedBox(height: 8),
                  Text("Loading..."),
                ],
              ),
            );
          }
          if (state is AyatLoaded) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 257,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.6, 1],
                              colors: [
                                AppColors.sage300,
                                AppColors.sage200,
                                AppColors.sage100,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Opacity(
                            opacity: 0.2,
                            child: SvgPicture.asset(
                              'assets/svg/quran.svg',
                              width: 324 - 55,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            children: [
                              Text(
                                widget.surat.namaLatin,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.surat.arti,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Divider(
                                color: Colors.white.withOpacity(0.35),
                                thickness: 2,
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _getSentenceCase(widget.surat.tempatTurun),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${widget.surat.jumlahAyat} Ayat",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              SvgPicture.asset('assets/svg/bismillah.svg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ayat = state.detail.ayat![index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.sage300,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/end_verse.svg',
                                          color: AppColors.white,
                                          width: 35,
                                          height: 35,
                                        ),
                                        Positioned(
                                          top: 2,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Center(
                                            child: Text(
                                              "${ayat.nomor}",
                                              style: GoogleFonts.poppins(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_add_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Card(
                                  color: (ayat.nomor! % 2 == 1)
                                      ? AppColors.sage
                                      : AppColors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Text(
                                            '${ayat.ar}',
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.amiri(
                                              textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                '${ayat.tr}',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.sage300),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                '\"${ayat.idn.toString()}\"',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ));
                    },
                    childCount: state.detail.ayat!.length,
                  ),
                ),
              ],
            );
          }
          if (state is AyatError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }
}
