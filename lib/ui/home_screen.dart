import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start_flutter/core/model/movie_resp.dart';
import 'package:start_flutter/core/service/service.dart';
import 'package:start_flutter/ui/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Service _service;

  //TabLayout
  List<Tab> _tabList = List();
  TabController _tabController;

  //linkImage
  var imageUrl = "http://image.tmdb.org/t/p/w500";
  var errorImage =
      "https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1350441335.jpg";

  //seperti onCreate atau onStart. yaitu code yang akan dijalankan pertama kali.
  @override
  void initState() {
    //log
    print("init HomeScreen");

    _service = Service();

    _tabList.add(new Tab(
      text: "Now Playing",
    ));
    _tabList.add(new Tab(
      text: "Up Comming",
    ));

    _tabController = new TabController(length: _tabList.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Movie"),
        bottom: TabBar(
          tabs: _tabList,
          controller: _tabController,
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          // FutureBuilder merupakan fungsi untuk mengakses Service

          //tampilan untuk Now Playing
          FutureBuilder<MovieResp>(
            //pemanggilan fungsi nowPlaying pada service
            future: _service.getNowPlaying(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //mengembalikan service lalu membuat tambilan list dengan bantuan listView.builder

                return ListView.builder(
                    //itemCount adalah jumlah data json
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.results[index];

                      return snapshot.data.results == null
                          ? Text("Tidak Ada Data.")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 150,
                                      width: 100,
                                      child: snapshot.data.results[index]
                                                  .posterPath !=
                                              null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image.network(
                                                imageUrl + data.posterPath,
                                                fit: BoxFit.cover,
                                              ))
                                          : Icon(Icons.home),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.blue,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.blue,
                                                blurRadius: 3)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              data.title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data.overview,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          //tampilan untuk Up Coming
          FutureBuilder<MovieResp>(
            future: _service.getUpComing(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.results[index];
                      //InkWell adalah widget yang berfungsi untuk dapat diklik
                      return InkWell(
                        //onTap merupakan fungsi ketika widget disentuh
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DetailScreen(
                                      movieItem: data,
                                    ))),
                        child: Stack(
                          children: <Widget>[
                            //Judul
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 50),
                                      child: ListTile(
                                        title: Text(data.title),
                                        subtitle:
                                            Text(data.releaseDate.toString()),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),

                            //Foto Movie
                            Positioned(
                              top: 20,
                              left: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      data.posterPath != null
                                          ? imageUrl + data.posterPath
                                          : errorImage,
                                    ),
                                    radius: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
