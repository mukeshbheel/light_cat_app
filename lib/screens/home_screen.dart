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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          _focusNode.unfocus();
          _focusNode2.unfocus();
          Future.delayed(const Duration(milliseconds: 100), () {
            _scaffoldKey.currentState?.openDrawer();
          });
        }, icon: const Icon(Icons.menu)),
        backgroundColor: Colors.black,
        // centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Random Cats",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(onPressed: (){
            providerCat.getNewCat();
          }, icon: const Icon(Icons.cached_sharp, color: Colors.white,))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: LottieBuilder.asset("assets/images/cat3.json")),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MyCatsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text('My Cats', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height-70,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                width: double.infinity,
                child: FittedBox(
                  child: Consumer<CatInfoController>(
                    builder: (context, catInfo, _) => Column(
                      children: [
                        catInfo.getCatLoading?
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              ),
                            ):
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*0.45,
                              // padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Colors.transparent,
                                    Colors.black,
                                  ],),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 1
                                    ),
                                  ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ShaderMask(
                                    shaderCallback: (bounds) => const LinearGradient(
                                      colors: [Colors.transparent, Colors.black38],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds),
                                    blendMode: BlendMode.dstOut,child: Image.network(catInfo.catImage, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if(loadingProgress == null) {
                                        return child;
                                      }else{
                                        return const SizedBox(width: 300, height : 300, child: Center(child: CircularProgressIndicator()));
                                      }
                                },)),
                              ),
                            ),
                            Positioned(
                              bottom: 25,
                              left: 30,
                              child: Text(catInfo.catName.toUpperCase(), style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(onPressed: (){
                                providerCat.setIsBookmarked(!catInfo.isBookmarked);
                                if(catInfo.isBookmarked){
                                  CatInfo cat = CatInfo(catInfo.id, catInfo.catName, catInfo.catImage);
                                  providerCat.saveCat(cat);
                                }else{
                                  providerCat.deleteCat(catInfo.id);
                                }
                              }, icon: Icon(catInfo.isBookmarked? Icons.bookmark : Icons.bookmark_border, color: Colors.yellow,)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Column(
                children: [

                  Align(alignment: AlignmentDirectional.centerStart, child: Text('Change Info !'.toUpperCase(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                  TextField(
                    focusNode: _focusNode,
                    controller: nameController,
                    onTapOutside: (s){
                      _focusNode.unfocus();
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Cat Name"),
                  ),
                  TextField(
                    focusNode: _focusNode2,
                    controller: imageController,
                    onTapOutside: (s){
                      _focusNode2.unfocus();
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Cat Image Url"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      providerCat.setCatName(nameController.text);
                      providerCat.setCatImage(imageController.text);
                      nameController.clear();
                      imageController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Colors.black
                    ),
                    child: const Text('Update Info', style: TextStyle(color: Colors.white),),
                  ),
                ].addElement(const SizedBox(height: 15,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
