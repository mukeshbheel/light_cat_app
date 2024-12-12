import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/controller/cat_info_controller.dart';
import 'package:provider_project/model/catInfo.dart';
import 'package:provider_project/widgets/pinch_zoom_image.dart';

class ViewCatScreen extends StatefulWidget {
  ViewCatScreen({super.key, required this.catInfo});

  final CatInfo catInfo;

  @override
  State<ViewCatScreen> createState() => _ViewCatScreenState();
}

class _ViewCatScreenState extends State<ViewCatScreen> {
  TextEditingController nameController = TextEditingController();
  String catName = '';

  @override
  void initState() {
    // TODO: implement initState
    catName = widget.catInfo.name;
    super.initState();
  }

  updateName(BuildContext context) {
    final providerCat = Provider.of<CatInfoController>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(5),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [providerCat.randomColor.withOpacity(0.005),
                        Colors.black,]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    // BoxShadow(
                        // color: Colors.grey,
                        // blurRadius: 5,
                        // spreadRadius: 2,
                        // offset: Offset(1, 5))
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LottieBuilder.asset("assets/images/cat1.json")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: "Cat Name",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (nameController.text.trim().isEmpty) return;
                          final providerCat = Provider.of<CatInfoController>(
                              context,
                              listen: false);
                          providerCat.updateCat(CatInfo(widget.catInfo.id,
                              nameController.text, widget.catInfo.imageUrl));
                          providerCat.getAllCats();
                          setState(() {
                            catName = nameController.text;
                          });
                          nameController.clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // colorString != null
                                  //     ? colorFromString(colorString!)
                                  //     : Colors.white,
                                  Colors.white,
                                  Colors.white,
                                ]),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(1, 5))
                            ],
                          ),
                          child: Center(
                              child: Image.asset("assets/images/done.png", width: 30, height: 30,)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(1, 5))
                            ],
                          ),
                          child: Center(
                              child: Image.asset("assets/images/cross.png", width: 30, height: 30,)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final providerCat = Provider.of<CatInfoController>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.1),
        // centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/back.png",
              width: 20,
              height: 20,
            )),
        title: Text(
          catName.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white,
              providerCat.randomColor.withOpacity(0.005)
            ])),
            // alignment: Alignment.topCenter,
            // height: MediaQuery.of(context).size.height-70,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: PinchZoomImage(
                  imgUrl: widget.catInfo.imageUrl,
                )),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black,
                        providerCat.randomColor
                      ],
                    )),
                    child: IconButton(
                        onPressed: () {
                          updateName(context);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            providerCat.randomColor
                          ],
                        )),
                    child: IconButton(
                      onPressed: () async {
                        await providerCat.saveImageManually(
                            context, widget.catInfo.imageUrl, catName);
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<CatInfoController>(builder: (context, catInfoController, _) {
            return catInfoController.saveImageLoading
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
