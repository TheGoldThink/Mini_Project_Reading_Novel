// ignore: file_names
// ignore_for_file: must_be_immutable, file_names, duplicate_ignore

import 'package:flutter/material.dart';

import '../ReadNovelScreen.dart';

class WidgetBook extends StatefulWidget {
  final Size tmpt;
  String judul, gambar, sinopsis, genre;
  List novel;
  bool fav;
  WidgetBook(
      {super.key,
      required this.tmpt,
      required this.sinopsis,
      required this.gambar,
      required this.judul,
      required this.novel,
      required this.fav,
      required this.genre});

  @override
  State<WidgetBook> createState() => _WidgetBookState();
}

class _WidgetBookState extends State<WidgetBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: widget.tmpt.height * .04),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReadNovel(
                                          index: 0,
                                          novel: widget.novel,
                                          gambar: widget.gambar,
                                        )));
                          },
                          child: const Text(
                            "Read Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    label: const Text("Add To Favorite"),
                    onPressed: () {},
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Image.network(
                  widget.gambar,
                  height: double.infinity,
                  alignment: Alignment.topRight,
                  fit: BoxFit.fitWidth,
                ),
              )),
        ],
      ),
    );
  }
}
