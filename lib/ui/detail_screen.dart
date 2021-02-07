import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_flutter/core/model/movie_item.dart';
import 'package:start_flutter/core/model/movie_resp.dart';

class DetailScreen extends StatefulWidget {
  //Constructor
  MovieItem movieItem;

  DetailScreen({this.movieItem});

  //untuk memanggil "widget.movieItem.paramYangDiinginkan"

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var imageUrl = "http://image.tmdb.org/t/p/w500";
  var errorImage =
      "https://www.simscale.com/forum/uploads/default/original/3X/5/9/59c3686cc01056f418145aeede2685600647cf8c.jpg";

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.movieItem.title),
      ),
      body: Column(
        children: <Widget>[

          Stack(
            children: <Widget>[
              Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: widget.movieItem.backDropPath != null
                      ? Image.network(
                          imageUrl + widget.movieItem.backDropPath,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          errorImage,
                          fit: BoxFit.cover,
                        )),
              Positioned(
                left: 10,
                top: 50,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 100,
                  width: 100,
                  child: widget.movieItem.posterPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            imageUrl + widget.movieItem.posterPath,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.network(errorImage),
                ),
              )
            ],
          ),

          SizedBox(height: 50,),

          Text(widget.movieItem.overview)

        ],
      ),
    );
  }
}
