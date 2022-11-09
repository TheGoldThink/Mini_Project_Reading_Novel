// ignore: file_names
// ignore_for_file: must_be_immutable, file_names, duplicate_ignore, use_build_context_synchronously

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:reading_novel_mini_project/boxes.dart';
import 'package:reading_novel_mini_project/models/favor.dart';
import 'package:reading_novel_mini_project/models/user_model.dart';

import '../../service/providers/profileProvider.dart';
import '../../service/providers/provider.dart';
import '../ReadNovelScreen.dart';

class WidgetBook extends StatefulWidget {
  final Size tmpt;
  String judul, gambar, sinopsis, genre;
  List novel;
  UserModel? user;
  WidgetBook({
    super.key,
    required this.tmpt,
    required this.sinopsis,
    required this.gambar,
    required this.judul,
    required this.novel,
    required this.genre,
    this.user,
  });

  @override
  State<WidgetBook> createState() => _WidgetBookState();
}

class _WidgetBookState extends State<WidgetBook> {
  late Box<Favorite> favbox;
  late List<String> fav;
  @override
  void initState() {
    super.initState();
    favbox = Boxes.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      fav = widget.user!.favorite;
    }
    return Flex(
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
                  icon: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color:
                        fav.contains(widget.judul) ? Colors.red : Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  label: fav.contains(widget.judul)
                      ? const Text("Remove Favorite",
                          style: TextStyle(color: Colors.red))
                      : const Text(
                          "Add To Favorite",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        text: fav.contains(widget.judul)
                            ? "Yakin Mau Delete?"
                            : "Yakin Mau Ditambahin?",
                        confirmBtnText: "Yes",
                        cancelBtnText: "No",
                        onConfirmBtnTap: () async {
                          if (fav.contains(widget.judul)) {
                            if (widget.user != null) {
                              widget.user!.favorite.remove(widget.judul);

                              final favor = UserModel(
                                id: widget.user!.id,
                                fName: widget.user!.fName,
                                lName: widget.user!.lName,
                                email: widget.user!.email,
                                phone: widget.user!.phone,
                                about: widget.user!.about,
                                favorite: widget.user!.favorite,
                              );
                              await Provider.of<UserProviders>(context,
                                      listen: false)
                                  .updateuser(favor);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Menghapus data...',
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (widget.user != null) {
                              widget.user!.favorite.add(widget.judul);

                              final favor = UserModel(
                                  id: widget.user!.id,
                                  fName: widget.user!.fName,
                                  lName: widget.user!.lName,
                                  email: widget.user!.email,
                                  phone: widget.user!.phone,
                                  about: widget.user!.about,
                                  favorite: widget.user!.favorite);
                              await Provider.of<UserProviders>(context,
                                      listen: false)
                                  .updateuser(favor);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Menambahkan data...',
                                  ),
                                ),
                              );
                            }
                          }
                          Navigator.pop(context);
                        },
                        onCancelBtnTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: fav.contains(widget.judul)
                                  ? Text("Data Favorit Tidak Dihapus...")
                                  : Text(
                                      'Data Tidak ditambahkan...',
                                    ),
                            ),
                          );
                          Navigator.pop(context);
                        });
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    favbox.containsKey(widget.judul)
                        ? Icons.check
                        : Icons.bookmark,
                    size: 20,
                    color: favbox.containsKey(widget.judul)
                        ? Colors.red
                        : Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: favbox.containsKey(widget.judul)
                          ? Colors.white30
                          : Colors.transparent),
                  label: favbox.containsKey(widget.judul)
                      ? const Text("Remove Bookmark",
                          style: TextStyle(color: Colors.red))
                      : const Text(
                          "Add To Bookmark",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () async {
                    final favor = Favorite(widget.judul, widget.sinopsis,
                        widget.gambar, widget.genre, widget.novel);
                    await Provider.of<NovelProvider>(context, listen: false)
                        .addFavorite(favor);
                  },
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
    );
  }
}
