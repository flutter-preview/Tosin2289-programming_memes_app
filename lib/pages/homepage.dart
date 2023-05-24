import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getmeme() async {
    try {
      var url = "https://programming-memes-images.p.rapidapi.com/v1/memes";
      Map<String, String> headers = {
        'X-RapidAPI-Key': 'b69cb11239mshab2a2abc94c6a70p16a0dbjsna6609ede3bdb',
        'X-RapidAPI-Host': 'programming-memes-images.p.rapidapi.com'
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      var jsonData = jsonDecode(response.body);
      List<user> Users = [];
      for (var u in jsonData) {
        user users = user(
          u['image'],
        );
        Users.add(users);
      }
      return Users;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text("Programming memes"),
        ),
        backgroundColor: Colors.blueAccent[400],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: SizedBox(
            child: FutureBuilder(
              future: getmeme(),
              builder: ((context, snapshot) {
                if (snapshot.data == null) {
                  return SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/laughing.json',
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Created by Phenomes',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getmeme();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10),
                      child: PageView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: 400,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data[index].image)),
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                snapshot.data[index].image,
                                fit: BoxFit.contain,
                              ),
                            );
                          })),
                    ),
                  );
                }
              }),
            ),
          ),
        ));
  }
}

class user {
  final String image;
  user(this.image);
}
