import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_novel_mini_project/boxes.dart';
import 'package:reading_novel_mini_project/models/favor.dart';
import 'package:reading_novel_mini_project/screens/detailview.dart';

class FavoriteScreens extends StatefulWidget {
  const FavoriteScreens({super.key});

  @override
  State<FavoriteScreens> createState() => _FavoriteScreensState();
}

class _FavoriteScreensState extends State<FavoriteScreens> {
  var box = Hive.openBox<Favorite>('favorite');
  @override
  Widget build(BuildContext context) {
    if (box == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        extendBody: true,
        body: ValueListenableBuilder<Box<Favorite>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final favo = box.values.toList().cast<Favorite>();
            return buildContent(favo);
          },
        ));
  }

  Widget buildContent(List<Favorite> favo) {
    if (favo.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada yang ditambahkan',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Your\nFavorite',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontFamily: 'Nisebuschgardens',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: favo.length,
                      itemBuilder: (context, index) {
                        final bb = favo[index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: ((direction) {
                            favo[index].delete();
                          }),
                          key: ObjectKey(bb),
                          child: InkWell(
                            child: Container(
                              height: 80,
                              child: Card(
                                elevation: 9,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: ListTile(
                                  dense: false,
                                  leading: Image.network(favo[index].gambar),
                                  title: Text(
                                    favo[index].judul,
                                    style: const TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailView(
                                        gambar: favo[index].gambar,
                                        nama: favo[index].judul,
                                        sinopsis: favo[index].sinopsis,
                                        genre: favo[index].genre,
                                        chapter: favo[index].ch),
                                  ));
                            },
                          ),
                        );
                      },
                    ),
                  ])));
    }
  }
}
