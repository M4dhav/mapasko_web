import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapsko/gallery/widgets/gallery_marquee.dart';
import 'package:mapsko/home/widgets/home_appbar.dart';
import 'package:mapsko/home/widgets/home_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final storageRef = FirebaseStorage.instance.ref();
  Map<String, List<String>> galleryImages = {};
  bool isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final dbRef =
      FirebaseFirestore.instance.collection('events').doc('eventList');
  Map<String, dynamic> events = {};

  List<Widget> generateMarquees() {
    List<Widget> marquees = [];
    for (var event in galleryImages.keys) {
      marquees.add(GalleryMarquee(
        galleryImages: galleryImages,
        eventName: event,
      ));
    }
    return marquees;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      events = await dbRef
          .get()
          .then((value) => events = value.data() as Map<String, dynamic>);
      for (var event in events.keys) {
        log(event);
        galleryImages[events[event]] = [];
        var listResult = await storageRef.child(event).listAll();
        for (var item in listResult.items) {
          String downloadURL = await item.getDownloadURL();
          galleryImages[events[event]]!.add(downloadURL);
        }
      }
      setState(() {
        log('Loaded');
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const HomePageDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(
              onPressedMobile: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            Text("EVENT GALLERY",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                )),
            if (isLoading)
              SizedBox(
                height: 90.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              ...generateMarquees(),
          ],
        ),
      ),
    );
  }
}
