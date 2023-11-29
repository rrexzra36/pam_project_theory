import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String selectedPackage = '';
  String price = '';
  DateTime expired = DateTime.now().add(Duration(days: 30));

  List<String> moneyRate = ['IDR', 'USD', 'WON'];
  String selectedMoneyRate = 'IDR';

  double usdRate =
      0.000065; // Rate for example purposes, replace with actual rates
  double wonRate =
      0.084; // Rate for example purposes, replace with actual rates
  double annual = 239900;
  double monthly = 239900 / 12;

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Get Premium",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.sage300,
        elevation: 0,
      ),
      backgroundColor: AppColors.deen,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: width / 20,
            right: width / 20,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    'Let\'s explore more features!',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Premium Benefit",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Shalat Schedule',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Download Audio',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Bookmark',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pilih Paket",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedMoneyRate,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMoneyRate = newValue!;
                                  _convertCurrency();
                                });
                              },
                              items: moneyRate.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                );
                              }).toList(),
                              dropdownColor: AppColors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'annual',
                              groupValue: selectedPackage,
                              onChanged: (value) {
                                setState(() {
                                  selectedPackage = value as String;
                                  price = "Rp 239900";
                                  expired =
                                      DateTime.now().add(Duration(days: 365));
                                  _convertCurrency();
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPackage = 'annual';
                                  price = "Rp 19992";
                                  expired =
                                      DateTime.now().add(Duration(days: 30));
                                  _convertCurrency();
                                });
                              },
                              child: Text(
                                'Annual',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  selectedMoneyRate == 'IDR'
                                      ? NumberFormat.currency(
                                              locale: 'ID',
                                              symbol: "Rp",
                                              decimalDigits: 0)
                                          .format(annual)
                                          .toString()
                                      : selectedMoneyRate == 'USD'
                                          ? NumberFormat.currency(
                                                  locale: 'en_US',
                                                  symbol: "\u0024",
                                                  decimalDigits: 0)
                                              .format(annual)
                                              .toString()
                                          : selectedMoneyRate == 'WON'
                                              ? NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: "\u20A9",
                                                      decimalDigits: 0)
                                                  .format(annual)
                                                  .toString()
                                              : "",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: AppColors.sage300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: width / 1.3,
                          child: const Divider(),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'monthly',
                              groupValue: selectedPackage,
                              onChanged: (value) {
                                setState(() {
                                  selectedPackage = value as String;
                                  _convertCurrency();
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPackage = 'monthly';
                                  _convertCurrency();
                                });
                              },
                              child: Text(
                                'Monthly',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  selectedMoneyRate == 'IDR'
                                      ? NumberFormat.currency(
                                              locale: 'ID',
                                              symbol: "Rp",
                                              decimalDigits: 0)
                                          .format(monthly)
                                          .toString()
                                      : selectedMoneyRate == 'USD'
                                          ? NumberFormat.currency(
                                                  locale: 'en_US',
                                                  symbol: "\u0024",
                                                  decimalDigits: 0)
                                              .format(monthly)
                                              .toString()
                                          : selectedMoneyRate == 'WON'
                                              ? NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: "\u20A9",
                                                      decimalDigits: 0)
                                                  .format(monthly)
                                                  .toString()
                                              : "",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: AppColors.sage300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height / 30, bottom: height / 30),
                  child: Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBuyNowDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.sage300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy Now',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.shopping_basket_outlined),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _convertCurrency() {
    double annualAmount;
    double monthlyAmount;
    switch (selectedMoneyRate) {
      case 'WON':
        annualAmount = 239900 * wonRate;
        monthlyAmount = (239900 / 12) * wonRate;
        break;
      case 'USD':
        annualAmount = 239900 * usdRate;
        monthlyAmount = (239900 / 12) * usdRate;
        break;
      default:
        annualAmount = 239900;
        monthlyAmount = 239900 / 12;
        break;
    }

    setState(() {
      annual = annualAmount;
      monthly = monthlyAmount;
    });
  }

  void _showBuyNowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
            'Are you sure you want to buy this package?',
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.sage300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Buy',
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
}
