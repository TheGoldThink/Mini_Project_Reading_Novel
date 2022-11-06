// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_novel_mini_project/screens/widgets/WidgetBook.dart';
import 'package:reading_novel_mini_project/screens/widgets/WidgetChapter.dart';

import '../boxes.dart';
import '../models/favor.dart';

// ignore: must_be_immutable
class DetailView extends StatefulWidget {
  final String? gambar, sinopsis, nama, genre;
  final List chapter;

  const DetailView({
    super.key,
    required this.gambar,
    required this.nama,
    required this.sinopsis,
    required this.genre,
    required this.chapter,
  });

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool muncul = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: size.height * .12,
                        left: size.width * .1,
                        right: size.width * .02),
                    height: size.height * .48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.genre == 'action'
                            ? "assets/bg_action.png"
                            : widget.genre == 'fantasy'
                                ? "assets/bg_fantasy.png"
                                : "assets/bg_romance.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: WidgetBook(
                        genre: widget.genre!,
                        sinopsis: widget.sinopsis!,
                        novel: widget.chapter,
                        tmpt: size,
                        gambar: widget.gambar!,
                        judul: widget.nama!),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline5,
                          children: [
                            TextSpan(text: widget.nama),
                            const TextSpan(
                              text: "\nSinopsis..",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: widget.genre == 'action'
                                ? Colors.black87
                                : widget.genre == 'fantasy'
                                    ? Colors.purple.shade300
                                    : Colors.pink.shade300),
                        onPressed: () {
                          setState(() {
                            muncul = !muncul;
                          });
                        },
                        icon:
                            Icon(muncul ? Icons.arrow_right : Icons.arrow_left),
                        label: Text(muncul ? "Show" : "Hide"),
                      ),
                      AnimatedCrossFade(
                        firstChild: Container(
                          color: Colors.blueGrey.shade50,
                          child: Text(widget.sinopsis!),
                        ),
                        secondChild: const Text(""),
                        crossFadeState: muncul
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var i = 0; i < widget.chapter.length; i++)
                      ChapterViewWidget(
                        judul: widget.chapter[i][0],
                        index: i,
                        image: widget.gambar!,
                        bambang: widget.chapter,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
