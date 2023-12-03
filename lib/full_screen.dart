import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullScreen extends StatefulWidget {

  //GETTING THE IMAGE URL FROM WALLPAPER SCREEN WHICH WE NEED TO BE DISPLAYED IN FULL SIZE
  final String  imageurl ;
  const FullScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  //FUNCTION FOR SETTING WALLPAPER ON MOBILE SCREEN
  Future<void> setWallpaper() async{

    //GETTING LOCATION WHERE WE WANT TO SET WALLPAPER AS I SELECT HOME YOU CAN SELECT LOCK OR BOTH, THIS IS DONE USING WALLPAPER MANAGER PACKAGE
    int location = WallpaperManager.HOME_SCREEN;

    //GETTING THE FILE WITH FLUTTER_CACHED_MANAGER PACKAGE
    var file= await DefaultCacheManager().getSingleFile(widget.imageurl);

    //NOW WALLPAPER MANAGER NEEDS 2 THINGS PATH AND LOCATION, WE HAVE BOTH NOW SIMPKY SET THE WALLPAPER
     bool result= await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageurl),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Container(
                  height: 60,
                  width: 180,
                  color: Colors.black,
                  child: TextButton(
                      onPressed: () {setWallpaper();},
                      child: Center(
                          child: Text(
                            "Set Wallpaper",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))),
                ),
                Container(
                  height: 60,
                  width: 180,
                  color: Colors.black,
                  child: TextButton(
                      onPressed: () {},
                      child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
