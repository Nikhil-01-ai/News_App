import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_headline/models/NewsChannelsHeadlinesModel.dart';
import 'package:news_headline/view-model/news_view_model.dart';
import 'package:news_headline/view/categoriesscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

enum Filterlist { arynews, independent, reuters, cnn, alJazeera, bbcnews }

class _HomescreenState extends State<Homescreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  Filterlist? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Categoriesscreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Center(
          child: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton<Filterlist>(
              initialValue: selectedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (Filterlist item) {
                if (Filterlist.bbcnews.name == item) {
                  name = 'bbc-news';
                }
                if (Filterlist.arynews.name == item) {
                  name = 'ary-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<Filterlist>>[
                    PopupMenuItem<Filterlist>(
                      value: Filterlist.bbcnews,
                      child: Text('BBC News'),
                    ),
                    PopupMenuItem<Filterlist>(
                      value: Filterlist.arynews,
                      child: Text('Ary News'),
                    )
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .5,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchnewsChannelHeadlinesApi(1),
              builder: (BuildContext context, snapshot) {
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
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );
                        return Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * .04,
                                    vertical: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(15),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * .7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
