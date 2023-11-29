import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    DateTime purchaseDate = DateTime.now();
    DateTime expiredMonthly = purchaseDate.add(Duration(days: 30));
    DateTime expiredYearly = purchaseDate.add(Duration(days: 365));

    String formattedPurchaseDate = DateFormat('yyyy-MM-dd').format(purchaseDate);
    String formattedExpiredMonthly = DateFormat('yyyy-MM-dd').format(expiredMonthly);
    String formattedExpiredYearly = DateFormat('yyyy-MM-dd').format(expiredYearly);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment History",
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
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: width / 30, right: width / 30),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.check_rounded,
                      size: 35,
                      color: AppColors.sage300,
                    ),
                  ),
                  title: Text(
                    'Bulanan',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF102945),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Purchase : $formattedPurchaseDate',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF102945),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Success',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Expired : $formattedExpiredMonthly',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF102945),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Rp 239.900',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF102945),
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
            );
          },
        ),
      ),
    );
  }
}
