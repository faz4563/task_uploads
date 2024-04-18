import 'dart:convert';

import 'package:demo_app/models/homeScreenModel.dart';
import 'package:demo_app/services/ApiController.dart';
import 'package:demo_app/utils/apiconstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.token});
final String token;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 List<HomScreenResponseModel>? data;

bool dataFound = false;
bool searchEnabled = false;
  final ScrollController _scrollController = ScrollController();
  TextEditingController filterController = TextEditingController();
int pageIndex = 5;
String filter = "";
  gettingData(String count)async{
    var response =await  ApiController.get("${ApiConstants.homeDataUrl}$count");
    data =  homScreenResponseModelFromJson(jsonEncode(response));

    filteredCardList();
    setState(() {
      dataFound = true;
    });
  }
 void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Reached the bottom of the list, load more data
      gettingData("${data!.length+ pageIndex}"); // Incrementing count for pagination
    }
  }

  @override
  void initState() {
     filterController.addListener(() {
      print(filterController.text);
      filter = filterController.text;
      setState(() {});
    });
    gettingData("$pageIndex");
    _scrollController.addListener(_scrollListener);
    super.initState();
  }
 
   List<HomScreenResponseModel> filteredCardList() {
    return data!.where((content) {
final itemMatch = content.title!.contains(filter.toLowerCase());
final priceMatch = content.price!.toString().contains(filter.toLowerCase());

     
     return itemMatch|| priceMatch;
      
       
    }).toList();}
  @override
  Widget build(BuildContext context) {
     final fullWidth = MediaQuery.of(context).size.width;
    final fullHeight = MediaQuery.of(context).size.height;
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon:   Icon(Icons.arrow_back_ios,color: Colors.grey.shade800, ),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 20,
          title: searchEnabled == false ? const Text(
          "Product List",
          ): Padding(
            padding:   EdgeInsets.symmetric(vertical: 5.h),
            child: TextFormField(
              controller: filterController,
              decoration: const InputDecoration(
                hintText: "Search with Name or Price"
              ),
            ),
          ),

          actions: [IconButton(onPressed: (){
            setState(() {
              searchEnabled = !searchEnabled;
            });
          }, icon: const Icon(Icons.search))],
        ),
        body: dataFound == true ? SizedBox(
          width: fullWidth,
          height: fullHeight,
          child:           
          ListView.builder(
            controller: _scrollController,
            itemCount: filteredCardList().length,
            itemBuilder: (context, index) {
              return Padding(
                padding:   EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                child: SizedBox(
                  height: 80.h,
                  width: fullWidth,
                  child: 
                  Card(
                    child: Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(filteredCardList()[index].image!,fit: BoxFit.contain, width: 80.w,height: 40.h,),
                          Flexible(
                            child: Padding( padding:   EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(filteredCardList()[index].title ?? "Title Of The Product",style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.sp,overflow: TextOverflow.ellipsis
                                  ),),

                                  Text(filteredCardList()[index].category ?? "Title Of The Product",style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.sp
                                  ),),
                                
                                SizedBox(
                                  height: 5.h,
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Row(
                                    children: [
                                      RatingBarIndicator(
                                      itemPadding: const EdgeInsets.all( 0.1),
                                      itemSize: 12.h,
                                          itemCount: 5,
                                        unratedColor: Colors.grey,
                                        rating: double.parse(filteredCardList()[index].rating!.rate!.toString()),
                                        itemBuilder: (context, index) => const Icon(Icons.star,color: Colors.yellow,),),
                                          Text("(${filteredCardList()[index].rating!.rate!.toString()})"),
                                                                            SizedBox(
                                    width: 10.w,
                                  ),
                                          Text("(${filteredCardList()[index].rating!.count!.toString()})")
                                    ],
                                  ),
                                ),
                                  SizedBox(
                                  height: 5.h,
                                ),
                                 Text("Price : ${filteredCardList()[index].price} \$",style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.sp
                                  ),),
                                 
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  
                ),
              );
            
          },),
        ): const Center(
          child: CircularProgressIndicator(),
      ),
    ));
  }
}