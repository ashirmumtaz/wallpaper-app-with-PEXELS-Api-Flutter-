import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screenpaper/full_screen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  //DECLARING A LIST FOR STORING IMAGES WHICH WE ARE GETTING FORM API
  List images = [];

//DECLARING A LIST FOR STORING IMAGES WHICH WE ARE GETTING FORM API
  List<String> url = [];

//DECLARING A VARIABLE FOR STORING PAGE NUMBER
  int page = 1;

  @override
  void initState() {
    super.initState();

    //AS THE APP START WE NEED TO RUN FETCH API FUNCTION TO GET DATA
    fetchingApi();
  }

//FETCHING DATA FROM API WITH THE HELP OF HTTP PACKAGE
  fetchingApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'H3X3VksW8S8o0G1hRQNfJt001nUlAD2Xtq8kFEVflCvvhwHKeEFv4DBb'
        }).then((value) {
      //STORING THE RESULT IN MAP TYPED VARIABLE
      Map result = jsonDecode(value.body);

      setState(() {
        //HERE WE ADD PHOTOS IN IMAGES LIST WHICH WE DECLARE EARLIER FROM THE WHOLE RESULT
        images = result['photos'];
        for (var image in images) {
          url.add(image['url']);
        }
      });
      print(url[0]);
    });
  }

//HERE IS THE FUNCTIONALITY OF LOAD MORE BUTTON
  loadMore() async {
    //INCREMENTING THE PAGE NUMBER AS THE BUTTON CLICKED
    setState(() {
      page++;
    });

    //DECLARING THE API FOR NEXT PAGE WITH THE "PAGE" PARAMs GIVEN BY API
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();

    //SAME HITTING THE API WITH THIS INCREMENTED PAGE NUMBER URL
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'H3X3VksW8S8o0G1hRQNfJt001nUlAD2Xtq8kFEVflCvvhwHKeEFv4DBb'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        //ADD NEW RESULTS IN EXISTING LIST
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'ScreenPaper',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount (
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                imageurl: images[index]['src']['large2x']))),
                    child: Container(
                      color: Colors.white,

                      //DISPLAYING THE TINY SIZE IMAGE IN GRID VIEW BY HITTING THE SRC AND THEN TINY
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          )),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.black,
            child: TextButton(
                onPressed: () {
                  //SIMPLY CALLING THE LOAD MORE FUNCTION ON TAPPING THE BUTTON
                  loadMore();
                },
                child: const Center(
                    child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }
}
