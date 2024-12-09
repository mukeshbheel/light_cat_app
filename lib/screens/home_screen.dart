import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/controller/cat_info_controller.dart';
import 'package:provider_project/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final providerCat = Provider.of<CatInfoController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // centerTitle: true,
        title: const Text(
          "My Cat Info",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(onPressed: (){
            providerCat.getNewCat();
          }, icon: const Icon(Icons.cached_sharp, color: Colors.white,))
        ],
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
                    controller: nameController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Cat Name"),
                  ),
                  TextField(
                    controller: imageController,
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
