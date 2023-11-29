import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../common/contants.dart';

class ShalatSchedule extends StatefulWidget {
  @override
  _ShalatScheduleState createState() => _ShalatScheduleState();
}

class _ShalatScheduleState extends State<ShalatSchedule> {
  late Stream<DateTime> _timeStream;
  late DateFormat _timeFormat;

  late PrayerTimes _prayerTimes;
  String _selectedTimezone = 'WIB'; // Default timezone is WIB

  @override
  void initState() {
    super.initState();
    _timeFormat = DateFormat.Hms();
    _timeStream =
        Stream<DateTime>.periodic(const Duration(seconds: 1), (count) {
      return DateTime.now();
    });

    final params = CalculationMethod.umm_al_qura.getParameters();
    final coordinates = Coordinates(-6.2088, 106.8456);
    final date = DateTime.now();
    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(date),
      params,
    );
    _prayerTimes = prayerTimes;
    _selectedTimezone = 'WIB'; // Default timezone is WIB
  }

  List<bool> _isActiveList = List.filled(5, false); // Assuming 5 prayer times

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Shalat',
          style: TextStyle(
            color: AppColors.sage300,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.sage300,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showTimeZoneSelection();
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.deen,
      ),
      backgroundColor: AppColors.deen,
      body: SingleChildScrollView(
        child: StreamBuilder<DateTime>(
          stream: _timeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DateTime currentTime = snapshot.data!;
              String formattedDate =
                  DateFormat('EEEE, d MMMM y').format(currentTime);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 232,
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                '${_timeFormat.format(currentTime)}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 250,
                                height: 2,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                formattedDate,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                )),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildPrayerTimeCard(
                      'Subuh', _getPrayerTime(_prayerTimes.fajr!), 0),
                  _buildPrayerTimeCard(
                      'Dhuhr', _getPrayerTime(_prayerTimes.dhuhr!), 1),
                  _buildPrayerTimeCard(
                      'Ashar', _getPrayerTime(_prayerTimes.asr!), 2),
                  _buildPrayerTimeCard(
                      'Maghrib', _getPrayerTime(_prayerTimes.maghrib!), 3),
                  _buildPrayerTimeCard(
                      'Isya', _getPrayerTime(_prayerTimes.isha!), 4),
                ],
              );
            } else {
              return Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Menggunakan tinggi layar penuh
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
          },
        ),
      ),
    );
  }

  void _showTimeZoneSelection() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.deen,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pilih Zona Waktu', style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                ),
              ),
              _buildTimeZoneRadioTile('WIB'),
              _buildTimeZoneRadioTile('WITA'),
              _buildTimeZoneRadioTile('WIT'),
              _buildTimeZoneRadioTile('UK'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeZoneRadioTile(String timezone) {
    return RadioListTile<String>(
      title: Text(
        timezone,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      value: timezone,
      groupValue: _selectedTimezone,
      onChanged: (value) {
        setState(() {
          _selectedTimezone = value!;
          Navigator.pop(
              context); // Close the bottom sheet after selecting a timezone
        });
      },
    );
  }

  DateTime _getPrayerTime(DateTime prayerTime) {
    // Function to adjust prayer time based on selected timezone
    if (_selectedTimezone == 'WIB') {
      return prayerTime.subtract(const Duration(hours: 0));
    } else if (_selectedTimezone == 'WITA') {
      return prayerTime.add(const Duration(hours: 1));
    } else if (_selectedTimezone == 'WIT') {
      return prayerTime.add(const Duration(hours: 2));
    } else {
      return prayerTime.subtract(const Duration(hours: 7));
    }
  }

  Widget _buildPrayerTimeCard(String title, DateTime time, int index) {
    String timezoneLabel = _selectedTimezone; // Label zona waktu yang dipilih

    // Mengatur label dan warna sesuai dengan zona waktu yang dipilih
    if (timezoneLabel == 'WIB') {
      timezoneLabel = ' WIB';
    } else if (timezoneLabel == 'WITA') {
      timezoneLabel = ' WITA';
    } else if (timezoneLabel == 'WIT') {
      timezoneLabel = ' WIT';
    } else if (timezoneLabel == 'UK') {
      timezoneLabel = ' UK';
    }

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.sage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.access_alarm_rounded,
            color: AppColors.sage300,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ),
        subtitle: Row(
          children: [
            Text(
              '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
              style: GoogleFonts.poppins(),
            ),
            Text(
              timezoneLabel,
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        trailing: Switch(
          value: _isActiveList[index],
          activeColor: AppColors.sage300,
          inactiveTrackColor: Colors.grey.shade300,
          inactiveThumbColor: Colors.grey.shade100,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            setState(() {
              _isActiveList[index] = value;
            });
          },
        ),
      ),
    );
  }
}
