import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/controller/cat_info_controller.dart';
import 'package:provider_project/model/catInfo.dart';
import 'package:provider_project/screens/my_cats_screen.dart';
import 'package:provider_project/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusNode = FocusNode();

  final FocusNode _focusNode2 = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerCat = Provider.of<CatInfoController>(context);
    return Consumer<CatInfoController>(
        builder: (context, catInfoController, _) => Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      _focusNode.unfocus();
                      _focusNode2.unfocus();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scaffoldKey.currentState?.openDrawer();
                      });
                    },
                    icon: Image.asset(
                      "assets/images/menu.png",
                      width: 20,
                      height: 20,
                    )),
                backgroundColor: Colors.black.withOpacity(0.1),
                // centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "Find A Cat",
                  style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 18, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        providerCat.getNewCat();
                      },
                      icon: Image.asset("assets/images/catSearch.png"))
                ],
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      catInfoController.randomColor.withOpacity(0.005)
                    ],
                  )),
                  child: Column(
                    children: [
                      DrawerHeader(
                          child:
                              LottieBuilder.asset("assets/images/cat3.json")),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyCatsScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'My Cats',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      catInfoController.randomColor.withOpacity(0.005)
                    ],
                  )),
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        width: double.infinity,
                        child: FittedBox(
                          child: Column(
                            children: [
                              catInfoController.getCatLoading
                                  ? Container(
                                      width: 300,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          // padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 2),
                                                    blurRadius: 1,
                                                    spreadRadius: 1),
                                              ]),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: ShaderMask(
                                                shaderCallback: (bounds) =>
                                                    const LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black38
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ).createShader(bounds),
                                                blendMode: BlendMode.dstOut,
                                                child: Image.network(
                                                  catInfoController.catImage,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return const SizedBox(
                                                          width: 300,
                                                          height: 300,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    }
                                                  },
                                                )),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 25,
                                          left: 30,
                                          child: Text(
                                            catInfoController.catName
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white60,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              onPressed: () {
                                                providerCat.setIsBookmarked(
                                                    !catInfoController
                                                        .isBookmarked);
                                                if (catInfoController
                                                    .isBookmarked) {
                                                  CatInfo cat = CatInfo(
                                                      catInfoController.id,
                                                      catInfoController.catName,
                                                      catInfoController
                                                          .catImage);
                                                  providerCat.saveCat(cat);
                                                } else {
                                                  providerCat.deleteCat(
                                                      catInfoController.id);
                                                }
                                              },
                                              icon: Icon(
                                                catInfoController.isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color: Colors.yellow,
                                              )),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      // const Divider(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Colors.black.withOpacity(0.1)),
                        child: Column(
                          children: [
                            // Align(
                            //     alignment: AlignmentDirectional.centerStart,
                            //     child: Text(
                            //       'Change Info !'.toUpperCase(),
                            //       style: const TextStyle(
                            //           color: Colors.black, fontWeight: FontWeight.bold),
                            //     )),
                            TextField(
                              focusNode: _focusNode,
                              controller: nameController,
                              onTapOutside: (s) {
                                _focusNode.unfocus();
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  hintText: "Cat Name"),
                            ),
                            if (false)
                              TextField(
                                focusNode: _focusNode2,
                                controller: imageController,
                                onTapOutside: (s) {
                                  _focusNode2.unfocus();
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 10),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    hintText: "Cat Image Url",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            InkWell(
                              onTap: () {
                                providerCat.setCatName(nameController.text);
                                providerCat.setCatImage(imageController.text);
                                nameController.clear();
                                imageController.clear();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.black,
                                      catInfoController.randomColor
                                          .withOpacity(0.005)
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Update Info',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ].addElement(const SizedBox(
                            height: 15,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
