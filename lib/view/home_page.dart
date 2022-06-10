// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlproject/Graphql/graphql_query.dart';
import 'package:graphqlproject/Graphql/graphql_provider.dart';
import 'package:graphqlproject/models/news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GraphQLProvider graphQLProvider = const GraphQLProvider();

  News? getNews;

  NewsModel? newsModel;

  @override
  void initState() {
    super.initState();

    getNewsData();
  }

  static String getPrettyJSONString(Map<String, dynamic>? data) {
    String response = const JsonEncoder.withIndent(" ").convert(data);

    return response;
  }

  void getNewsData() async {
    GraphQLClient client = GraphqlProvider().clientToQuery();

    QueryResult result = await client
        .query(QueryOptions(document: gql(QueryClass().readQuery)));

    String responseDetails = getPrettyJSONString(result.data);

    var response = json.decode(responseDetails);
    print(result.data);

    newsModel = NewsModel.fromJson(response);
    // getNews = News.fromJson(response);
    setState(() {});
    print("It is Working");
    print(newsModel!.news.first.title);
  }

  Widget mainWidget(News model) {
    var s = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: s.height * 0.3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: model.urlToImage,
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Latest",
            style: TextStyle(
                color: Colors.orange, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            model.title,
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        authorWidget(model),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Text(
            model.content,
            style: const TextStyle(
                fontWeight: FontWeight.w500, wordSpacing: 2.5),
          ),
        )
      ],
    );
  }

  Row authorWidget(News model) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk3DgP-r2jcJjdzms_C_WYKnBPK0SdMUE8xA&usqp=CAU")),
              shape: BoxShape.circle,
              color: Colors.blue),
          height: 50,
          width: 70,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.author,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("Author ${model.publishedAt}")
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[400],
            title: const Text("Home Page"),
          ),
          body: Column(
            children: [
              newsModel != null
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: newsModel!.news.length,
                        itemBuilder: (context, index) {
                          News model = newsModel!.news[index];
                          return mainWidget(model);
                        },
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 350,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
            ],
          )),
    );
  }
}
