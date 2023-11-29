import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:flutter_ahlul_quran_app/cubit/surat/surat_cubit.dart';
import 'package:flutter_ahlul_quran_app/ui/ayat_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/surat_model.dart';

class SuratPage extends StatefulWidget {
  const SuratPage({Key? key}) : super(key: key);

  @override
  State<SuratPage> createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> {
  late List<SuratModel> originalSuratList;
  List<SuratModel> filteredSuratList = [];

  @override
  void initState() {
    context.read<SuratCubit>().getAllSurat();
    super.initState();
  }

  void filterSuratList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSuratList = List.from(originalSuratList);
      } else {
        filteredSuratList = originalSuratList
            .where((surat) =>
                surat.nama!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Quran',
          style: TextStyle(
            color: AppColors.sage300,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.sage300,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.deen,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: SuratSearchDelegate(filteredSuratList),
              );
              if (query != null && query.isNotEmpty) {
                filterSuratList(query);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<SuratCubit, SuratState>(
        builder: (context, state) {
          if (state is SuratLoading) {
            return Container(
              color: AppColors.deen,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: AppColors.sage300,
                    ),
                    SizedBox(height: 8),
                    Text("Loading..."),
                  ],
                ),
              ),
            );
          }
          if (state is SuratLoaded) {
            originalSuratList = state.listSurat;
            filteredSuratList = List.from(originalSuratList);

            return ListView.builder(
              itemBuilder: (context, index) {
                final surat = filteredSuratList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AyatPage(surat: surat);
                      }),
                    );
                  },
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
                                  "${surat.nomor}",
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
                          surat.namaLatin,
                          style: GoogleFonts.poppins(),
                        ),
                        subtitle: Text(
                          '${surat.jumlahAyat} Ayat',
                        ),
                        trailing: Text(
                          surat.nama,
                          style: GoogleFonts.amiri(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: AppColors.sage300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: filteredSuratList.length,
            );
          }
          if (state is SuratError) {
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

class SuratSearchDelegate extends SearchDelegate<String> {
  final List<SuratModel> suratList;

  SuratSearchDelegate(this.suratList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: AppColors.sage300,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme.of(context).copyWith(
        backgroundColor: AppColors.deen,
        elevation: 0,
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: AppColors.sage300,
        ),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.sage300,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  Widget _buildSearchResults(BuildContext context, String query) {
    final searchResults = suratList
        .where((surat) =>
            surat.namaLatin.toLowerCase().contains(query.toLowerCase()) ||
            surat.arti.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: AppColors.deen,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final surat = searchResults[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AyatPage(surat: surat);
                }),
              );
            },
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
                            "${surat.nomor}",
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
                    surat.namaLatin,
                    style: GoogleFonts.poppins(),
                  ),
                  subtitle: Text(
                    '${surat.jumlahAyat} Ayat',
                  ),
                  trailing: Text(
                    surat.nama,
                    style: GoogleFonts.amiri(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: AppColors.sage300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: searchResults.length,
      ),
    );
  }
}
