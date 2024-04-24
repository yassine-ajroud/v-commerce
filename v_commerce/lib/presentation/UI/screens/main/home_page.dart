import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/products_item.dart';
import 'package:v_commerce/presentation/UI/widgets/promotion_item.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
        var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer:const Drawer(),
        body: CustomScrollView(
          
          slivers:true? [
           
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading:Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: SvgPicture.string(APPSVG.menuIcon)),
              ) ,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
       shadowColor: Colors.grey,
                actions: [IconButton(onPressed: (){}, icon: SvgPicture.string(APPSVG.cartIcon))],
                expandedHeight: 210.h,
                pinned: true,
                floating: true,
                snap: true,
                flexibleSpace:FlexibleSpaceBar(
          background: Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                SearchInput(),
                SizedBox(height: 20.h,),
                Text('Visualisez avant de construire !',style: AppTextStyle.blackTitleTextStyle),
                   const SizedBox(height: 10,),
                   Container(
                            width: 120.w,
                            height: 35.h,
                            decoration: BoxDecoration(color:AppColors.secondary,
                                                  borderRadius: BorderRadius.circular(30),
                 
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [Text('Visualiser',style: AppTextStyle.smallDarkButtonTextStyle,),SvgPicture.string(APPSVG.arIcon,)],),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),      

               SliverToBoxAdapter(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const SizedBox(height:10),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 2),
                  child: Text('Nos promotions',style: AppTextStyle.blackTitleTextStyle,),
                ),
               const SizedBox(height: 10,),
               GetBuilder<PromotionController>(
                init:PromotionController(),
                 builder:(promotionController)=> FutureBuilder(
                   future: promotionController.getAllPromotions(),
                   builder: (context, snapshot) {
                    if(snapshot.hasData){
                    //  print(promotionController.promotionsList);
                     return promotionController.promotionsList.isEmpty?const Center(child: Text('no promotions')) :CarouselSlider.builder(
                      
                          options: CarouselOptions(height: 160.h,
                 viewportFraction: 0.85,

                          enableInfiniteScroll :false,
                          autoPlay :true,
                          enlargeCenterPage: true,
                          autoPlayInterval :const Duration(seconds: 5)
                          ),
  itemCount: promotionController.promotionsList.length,
  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
 return  PromotionWidget(image:promotionController.promotionsList[itemIndex].image,text:promotionController.promotionsList[itemIndex].text,percentage: promotionController.promotionsList[itemIndex].discount,);
  }
);
                    }else if(snapshot.connectionState==ConnectionState.waiting)  {
                            return const Center(child:CircularProgressIndicator());

                    }else{
                    return Text('error');
                   }
                     
                   }
                 ),
               ),
                      ]),) ,

                SliverToBoxAdapter(
                  child: Padding(
                   padding: const EdgeInsets.only(right: 20,left: 20,top:20,bottom: 5),
                   child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Top Vente',style: AppTextStyle.blackTitleTextStyle,),Text('Voir tout',style: AppTextStyle.hintTextStyle,),
                          ]),
                               ),
                ) ,
                   SliverToBoxAdapter(
            child: SizedBox(
              height: 250.h,
              child: ListView.builder(
                padding:const EdgeInsets.symmetric(horizontal:20,vertical: 5),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductItem();
                },
              ),
            ),
          ),
           SliverToBoxAdapter(
                  child: Padding(
                   padding: const EdgeInsets.only(right: 20,left: 20,top:25,bottom: 5),
                   child: Text('Catégories',style: AppTextStyle.blackTitleTextStyle,),
                               ),
                ) ,
         SliverToBoxAdapter(
            child: GridView.custom(
              padding:  EdgeInsets.symmetric(horizontal:20,vertical: 5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
               // repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(2, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(2, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  height:  50,
                  child: Text("$index"),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.lightBlue),
                ),
                childCount: 20,
              ),
            ),
          )
              //  SliverList.builder(
              
              //   itemCount: 20,
              //   itemBuilder: (_,i)=>  Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
              //     child: Container(
              //             width: double.infinity,
              //             height: 80,
              //             decoration: BoxDecoration(color: Color.fromARGB(244, 81, 10, 139),
              //             borderRadius: BorderRadius.circular(15)),
              //           ),
              //   ))
          //     SliverToBoxAdapter(
          //   child: Container(
          //     height: 170.h,
          //     child: GridView.builder(
          //       gridDelegate:
          //                               SliverGridDelegateWithFixedCrossAxisCount(
          //                             childAspectRatio:0.72,
          //                             //mainAxisExtent: 200,
          //                             crossAxisCount:
          //                                 2, // number of items in each row
          //                             mainAxisSpacing:
          //                                 2.0.h, // spacing between rows
          //                             crossAxisSpacing:
          //                                 2.0.w, // spacing between columns
          //                           ),
          //                       scrollDirection: Axis.vertical,
          //       padding: EdgeInsets.symmetric(horizontal:20,vertical: 5),
          //       itemCount: 10,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal:8.0),
          //           child: Container(               
          //             width: 150.w,
          //             decoration: BoxDecoration(
          //                color: Colors.blueAccent,
          //                borderRadius: BorderRadius.circular(15)
          //             ),
                      
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          ]:[
               SliverAppBar(
              automaticallyImplyLeading: false,
              leading:Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: SvgPicture.string(APPSVG.menuIcon)),
              ) ,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
       shadowColor: Colors.grey,
                actions: [IconButton(onPressed: (){}, icon: SvgPicture.string(APPSVG.cartIcon))],
                expandedHeight: 210.h,
                pinned: true,
                floating: true,
                snap: true,
                flexibleSpace:FlexibleSpaceBar(
          background: Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                SearchInput(),
                SizedBox(height: 20.h,),
                Text('Visualisez avant de construire !',style: AppTextStyle.blackTitleTextStyle),
                   const SizedBox(height: 10,),
                   Container(
                            width: 120.w,
                            height: 35.h,
                            decoration: BoxDecoration(color:AppColors.secondary,
                                                  borderRadius: BorderRadius.circular(30),
                 
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [Text('Visualiser',style: AppTextStyle.smallDarkButtonTextStyle,),SvgPicture.string(APPSVG.arIcon,)],),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),      

               SliverToBoxAdapter(child: Padding(
                 padding: const EdgeInsets.all(20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Nos promotions',style: AppTextStyle.blackTitleTextStyle,),
                 const SizedBox(height: 10,),
                 Container(
                          width: double.infinity,
                          height: 160.h,
                          decoration: BoxDecoration(color: Color.fromARGB(255, 42, 61, 148),
                                                borderRadius: BorderRadius.circular(30),
               
                          ),
                        ),
                        ]),
               ),) ,
          ]
        ),
      ),
    );
  }
}