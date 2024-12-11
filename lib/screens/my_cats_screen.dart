import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/controller/cat_info_controller.dart';
import 'package:provider_project/screens/view_cat_screen.dart';

class MyCatsScreen extends StatefulWidget {
  const MyCatsScreen({super.key});

  @override
  State<MyCatsScreen> createState() => _MyCatsScreenState();
}

class _MyCatsScreenState extends State<MyCatsScreen> {

  CatInfoController? providerCat;

  @override
  Widget build(BuildContext context) {
    providerCat = Provider.of<CatInfoController>(context);
    providerCat!.getAllCats(skipNotifyListener: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("My Cats", style: TextStyle(color: Colors.white, fontSize: 18),),
      ),
      body: Column(
        children: [
        Consumer<CatInfoController>(builder: (context, catInfoController, _){
          return Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 8, // Vertical spacing
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(10),
              itemCount: catInfoController.cats.length, // Replace with the length of your notes list
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewCatScreen(catInfo: catInfoController.cats[index],)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height*0.45,
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
                              blendMode: BlendMode.dstOut,child: Image.network(catInfoController.cats[index].imageUrl, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if(loadingProgress == null) {
                              return child;
                            }else{
                              return const SizedBox(width: 300, height : 300, child: Center(child: CircularProgressIndicator()));
                            }
                          },)),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(catInfoController.cats[index].name.toUpperCase(), style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(onPressed: (){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            contentPadding: const EdgeInsets.all(5),
                            actionsPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            content: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      Colors.black87
                                    ]),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: Offset(1, 5))
                                ],
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: LottieBuilder.asset("assets/images/cat2.json")),
                                  const SizedBox(height: 20,),
                                  const Text('Are you sure you want to remove this cat?', style: TextStyle(color: Colors.white, fontSize: 16),),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        // DbServices().deleteNote(widget.noteModel!);
                                        providerCat?.deleteCat(catInfoController.cats[index].id);
                                        providerCat?.getAllCats();
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
                                                Colors.black87,
                                                Colors.black87,
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
                                        child: const Center(child: Text("Yes", style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black87,
                                                Colors.black87,
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
                                        child: const Center(child: Text("No", style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ));
                        }, icon: const Icon( Icons.bookmark, color: Colors.yellow,)),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
    }),

        ],
      ),
    );
  }
}
