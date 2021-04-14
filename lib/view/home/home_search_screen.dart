import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot qs;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getDoc();
    super.initState();
  }

  Future<void> getDoc() async {
    qs = await db.collection('group').get();
    print(qs.docs[1].data()["imageURL"]);
    print('aa');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(
                  '그룹 추천',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            FutureBuilder(
                future: db.collection('group').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildList();
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemCount: qs.docs.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(i);
        });
  }

  Widget _buildRow(int i) {
    return Container(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: qs.docs[i].data()["imageURL"],
            width: 50,
            height: 50,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(qs.docs[i].data()['name'])
        ],
      ),
    );
  }
}
