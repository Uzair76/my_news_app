import 'package:flutter/material.dart';
import 'package:my_news_app/model/news_channels_categories_model.dart';
import 'package:my_news_app/model/news_channels_headlines_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/view/categories_screen.dart';
import 'package:my_news_app/view/news_details.dart';
import 'package:my_news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList {bbcNews, aryNews, independent, reuters, cnn, alJazeera}

class _HomeScreenState extends State<HomeScreen> {

  FilterList? selectedMenu;

  NewsViewModel newsViewModel= NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String name= 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final _height= MediaQuery.sizeOf(context) .height * 1;
    final _width= MediaQuery.sizeOf(context) .width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsCategoriesScreen()));
          },
          icon: Image.asset('images/category_icon.png',
            height: 30,
            width: 30,),
        ),
        centerTitle: true,
        title: Text('News',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
              onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.cnn.name == item.name){
                name = 'cnn-news';
              }
              if(FilterList.alJazeera.name == item.name){
                name = 'al-jazeera-english';
              }
              setState(() {
                selectedMenu = item;
              });
              },
              itemBuilder: (
              BuildContext context)=><PopupMenuEntry<FilterList>>[
                PopupMenuItem(
                    value: FilterList.bbcNews,
                    child: Text('BBC News')),
                PopupMenuItem(
                    value: FilterList.aryNews,
                    child: Text('ARY News')),
                PopupMenuItem(
                    value: FilterList.cnn,
                    child: Text('CNN News')),
                PopupMenuItem(
                    value: FilterList.alJazeera,
                    child: Text('Al Jazera')),

          ])

        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: _height * .55,
            width: _width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
                builder: (BuildContext context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context, index){
                        DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                NewsDetails(
                                    newimage: snapshot.data!.articles![index].urlToImage.toString(),
                                    source: snapshot.data!.articles![index].source!.name.toString(),
                                    author: snapshot.data!.articles![index].author.toString(),
                                    content: snapshot.data!.articles![index].content.toString(),
                                    description: snapshot.data!.articles![index].description.toString(),
                                    newsTitle: snapshot.data!.articles![index].title.toString(),
                                    newsData: snapshot.data!.articles![index].publishedAt.toString() ,
                                )));
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: _height* .6,
                                  width: _width*.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: _height*0.02
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url)=> Container(child: spinkit2,),
                                      errorWidget: (context,url,error)=> Icon(Icons.error_outline_rounded,color: Colors.red,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: _height*0.02,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Container(
                                      height: _height*.22,
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: _width*.7,
                                            child: Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: _width*.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                Text(format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500
                                                  ),

                                                )
                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<NewsChannelsCategoriesModel>(
                future: newsViewModel.fetchNewsChannelsCategories('General'),
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
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    NewsDetails(
                                      newimage: snapshot.data!.articles![index].urlToImage.toString(),
                                      source: snapshot.data!.articles![index].source!.name.toString(),
                                      author: snapshot.data!.articles![index].author.toString(),
                                      content: snapshot.data!.articles![index].content.toString(),
                                      description: snapshot.data!.articles![index].description.toString(),
                                      newsTitle: snapshot.data!.articles![index].title.toString(),
                                      newsData: snapshot.data!.articles![index].publishedAt.toString() ,
                                    )));
                              },
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
                                            Text(snapshot.data!.articles![index].title.toString(),
                                              maxLines: 3,
                                              style:
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
                                                        fontWeight: FontWeight.w500
                                                    ),),
                                                ),
                                                Expanded(
                                                  child: Text(format.format(dateTime),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500
                                                    ),

                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                }),
          ),
        ],
      ),

    );
  }
}

const spinkit2=SpinKitFadingCircle(
  size: 50,
  color: Colors.blue,
);