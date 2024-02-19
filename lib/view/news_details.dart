
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatelessWidget {
  String newimage, newsTitle, author ,description, content,source,newsData ;

   NewsDetails({
    super.key,
    required this.newimage,
    required this.source,
    required this.author,
    required this.content,
    required this.description,
    required this.newsTitle,
     required this.newsData
  });
 

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context) .height* 1;
    final _width = MediaQuery.sizeOf(context) .width* 1;
    final format = DateFormat('MMMM dd, yyyy');
    final dateTime = DateTime.parse(newsData);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: _height* .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)
              ),
              child: CachedNetworkImage(
                imageUrl: newimage,
                fit: BoxFit.cover,
                placeholder: (context, url)=> const CircularProgressIndicator(),
              ),
            ) ,
          ),
          Container(
            height: _height*.6,
            margin: EdgeInsets.only(top: _height* .4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,right: 20,left: 20
            ),
            child: ListView(
              children: [
                Text(newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w700),),
                SizedBox(height: _height* 0.02,),

                Row(
                  children: [
                    Expanded(
                      child: Text(source,
                        style: GoogleFonts.poppins(
                            fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w600),),
                    ),
                    Text(format.format(dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(height: _height* 0.03,),
                Text(description,
                  style: GoogleFonts.poppins(
                      fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),

              ],
            ),
          )
        ],
      )

    );
  }
}
