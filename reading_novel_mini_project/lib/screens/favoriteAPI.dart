// ignore_for_file: use_build_context_synchronously, file_names

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_novel_mini_project/models/novelModeldata.dart';
import 'package:reading_novel_mini_project/models/user_model.dart';
import 'package:reading_novel_mini_project/screens/detailview.dart';

import '../service/providers/profileProvider.dart';
import '../service/providers/provider.dart';

class FavoriteAPI extends StatefulWidget {
  const FavoriteAPI({super.key});

  @override
  State<FavoriteAPI> createState() => _FavoriteAPIState();
}

class _FavoriteAPIState extends State<FavoriteAPI> {
  late List<UserModel> profile;
  late List<IsiNovel> novel;
  List<IsiNovel> novelss = [];
  @override
  Widget build(BuildContext context) {
    final isloading =
        Provider.of<UserProviders>(context).state == novelState.loading;
    final isError =
        Provider.of<UserProviders>(context).state == novelState.error;
    profile = Provider.of<UserProviders>(context).isiProfile;
    novel = Provider.of<NovelProvider>(context).isinovelnya;

    for (int i = 0; i < novel.length; i++) {
      if (profile[0].favorite.contains(novel[i].name)) {
        if (novelss.contains(novel[i])) {
        } else {
          novelss.add(novel[i]);
        }
      }
    }
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : isError || profile.isEmpty
            ? const Center(
                child: Text("Saat ini anda sedang dalam mode offline"),
              )
            : profile[0].favorite.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak Ada\n Data Favorite',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontFamily: 'Nisebuschgardens',
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
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
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: novelss.length,
                                itemBuilder: (context, index) {
                                  final bb = novelss[index];
                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: ((direction) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.confirm,
                                        text: "Yakin mau Delete?",
                                        confirmBtnText: "Yes",
                                        cancelBtnText: "Bring Back",
                                        onConfirmBtnTap: () async {
                                          if (profile[0]
                                              .favorite
                                              .contains(novelss[index].name)) {
                                            profile[0]
                                                .favorite
                                                .remove(novelss[index].name);
                                            final favor = UserModel(
                                                id: profile[0].id,
                                                fName: profile[0].fName,
                                                lName: profile[0].lName,
                                                email: profile[0].email,
                                                phone: profile[0].phone,
                                                about: profile[0].about,
                                                favorite: profile[0].favorite);
                                            await Provider.of<UserProviders>(
                                                    context,
                                                    listen: false)
                                                .updateuser(favor);
                                            novelss.removeAt(index);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Menghapus data...',
                                                ),
                                              ),
                                            );
                                          }
                                          Navigator.pop(context);
                                        },
                                        onCancelBtnTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Data akan dikembalikan ketika anda kembali...',
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                    key: ObjectKey(bb),
                                    child: InkWell(
                                      child: SizedBox(
                                        height: 80,
                                        child: Card(
                                          elevation: 12,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                          ),
                                          child: ListTile(
                                            dense: false,
                                            leading: Image.network(
                                                novelss[index].image),
                                            title: Text(
                                              novelss[index].name,
                                              style: const TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            trailing: const Icon(
                                                Icons.arrow_forward_ios),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailView(
                                                gambar: novelss[index].image,
                                                nama: novelss[index].name,
                                                sinopsis:
                                                    novelss[index].sinopsis,
                                                genre: novelss[index].genre,
                                                chapter: novelss[index].ch,
                                                user: profile[0],
                                              ),
                                            ));
                                      },
                                    ),
                                  );
                                },
                              ),
                            ])));
  }
}
