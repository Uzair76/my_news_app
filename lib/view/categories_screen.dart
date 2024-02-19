import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/model/news_channels_categories_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_news_app/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCategoriesScreen extends StatefulWidget {
  const NewsCategoriesScreen({super.key});

  @override
  State<NewsCategoriesScreen> createState() => _NewsCategoriesScreenState();
}

class _NewsCategoriesScreenState extends State<NewsCategoriesScreen> {

  NewsViewModel newsViewModel= NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String categoryname= 'General';

  List<String> categoryList=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];


  @override
  Widget build(BuildContext context) {
    final _height= MediaQuery.sizeOf(context) .height * 1;
    final _width= MediaQuery.sizeOf(context) .width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        categoryname =categoryList[index];
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(

                          decoration: BoxDecoration(
                            color: categoryname == categoryList[index]? Colors.blue: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(categoryList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.white
                              ),),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: _height*.02,),
            Expanded(
              child: FutureBuilder<NewsChannelsCategoriesModel>(
                future: newsViewModel.fetchNewsChannelsCategories(categoryname),
                builder: (BuildContext context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: _height * .18,
                                    width: _width * .3,

                                    placeholder: (context, url) =>
                                        Container(child: SpinKitCircle(
                                          size: 50,
                                          color: Colors.blue,
                                        ),),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      height: _height*.18,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),style:
                                            GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black45
                                            ),),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500
                                                ),

                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }
                    );
                  }
                }),
            )
      ]
      ),

      ) );
  }
}
