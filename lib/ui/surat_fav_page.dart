import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:flutter_ahlul_quran_app/data/models/surat_favorite_model.dart';
import 'package:flutter_ahlul_quran_app/database/sqlite.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratFavPage extends StatefulWidget {
  const SuratFavPage({super.key});

  @override
  State<SuratFavPage> createState() => _SuratFavPageState();
}

class _SuratFavPageState extends State<SuratFavPage> {
  late SharedPreferences _logindata;
  late int usrId;
  List<SuratFav> listSuratFav = [];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      usrId = _logindata.getInt('userId')!;
    });
    _loadFavoriteData();
  }

  //get list payment
  Future<void> _loadFavoriteData() async {
    final db = await DatabaseHelper();
    List<Map<String, dynamic>> favoriteList = await db.getListFavorite(usrId);
    List<SuratFav> suratFav =
        favoriteList.map((map) => SuratFav.fromMap(map)).toList();

    setState(() {
      listSuratFav = suratFav;
    });
    print(favoriteList);
  }

  //delete favorite
  Future<void> _deleteFavorite(int id) async {
    final db = await DatabaseHelper();
    await db.deleteFavorite(id);
    //snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil menghapus surat dari bookmark'),
      ),
    );
    initial();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Surat Bookmark",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: AppColors.sage300,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.deen,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.sage300,
        ),
      ),
      body: Container(
        color: AppColors.deen,
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: listSuratFav.length,
          itemBuilder: (context, index) {
            var suratFav = listSuratFav[index];
            return InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: AppColors.deen,
                ),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: ListTile(
                      leading: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/nomor_surah.svg',
                            color: AppColors.beige,
                            width: 40,
                            height: 40,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: GoogleFonts.poppins(
                                  color: AppColors.sage300,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        suratFav.namaSuratLatin, //nama surat indonesia
                        style: GoogleFonts.poppins(),
                      ),
                      subtitle: Text(
                        suratFav.jumlahAyatSurat, //jumlah ayat
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   'trailing', //nama surat arab
                          //   style: GoogleFonts.amiri(
                          //     textStyle: const TextStyle(
                          //       fontSize: 20,
                          //       color: AppColors.sage300,
                          //     ),
                          //   ),
                          // ),
                          IconButton(
                              onPressed: () {
                                _deleteFavorite(suratFav.id);
                              },
                              icon: Icon(
                                Icons.bookmark_remove_rounded,
                                color: AppColors.sage300,
                              ))
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
