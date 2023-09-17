import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 80),
          buildBio(),
          SizedBox(height: 200),
          buildGambar(),
        ]
      ),
    );
  }

  Widget buildGambar() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.asset('assets/FTI UNTAR.png'),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.asset('assets/Logo SI clear.png',width: 164,height: 66,),
        ),
      ],
    );
  }

  Widget buildBio() {
    return Container(
      child: Row(
        children: [
          Container(
            child: Image.asset('assets/Logo Untar Vertikal .png',width: 130,height: 130,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Andy Wijaya Nusantara',
                  style: GoogleFonts.montserrat(fontSize: 20.0,color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '825210077',
                  style: GoogleFonts.montserrat(fontSize: 20.0,color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
