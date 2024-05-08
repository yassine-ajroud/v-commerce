import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/product/product_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/products_item.dart';
import 'package:v_commerce/presentation/UI/widgets/promotion_item.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
        var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer:const Drawer(),
        body: RefreshIndicator(
          color: AppColors.secondary,
          onRefresh: () async{
            setState(() {
              
            });
          },
          child: GetBuilder<ProductController>(
            id:ControllerID.PRODUCT_FILTER,
            init: ProductController(),
            builder: (pc) {
              return CustomScrollView(
                
                slivers: pc.searchController.text==""? [
                 
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
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
                  child: Builder(
                    builder: (ctx) {
                      return GetBuilder<ProductController>(
                        init: ProductController(),
                        builder: (prdController) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                               SearchInput(controller: prdController.searchController,onChanged: (v){
                                prdController.filterProducts(v);
                              },),
                              SizedBox(height: 20.h,),
                              Text(AppLocalizations.of(context)!.visualize_before_building,style: AppTextStyle.blackTitleTextStyle),
                                 const SizedBox(height: 10,),
                                 InkWell(
                                  onTap: (){
                                     Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const ProductScreen()));
                                  },
                                   child: Container(
                                            width: 120.w,
                                            height: 35.h,
                                            decoration: BoxDecoration(color:AppColors.secondary,
                                                                  borderRadius: BorderRadius.circular(30),
                                                                
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [Text(AppLocalizations.of(context)!.visualize,style: AppTextStyle.smallDarkButtonTextStyle,),SvgPicture.string(APPSVG.arIcon,)],),
                                            ),
                                          ),
                                 ),
                            ],
                          );
                        }
                      );
                    }
                  ),
                ),
              ),
              ),      
        
                     SliverToBoxAdapter(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const SizedBox(height:10),
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 2),
                        child: Text(AppLocalizations.of(context)!.our_promotions,style: AppTextStyle.blackTitleTextStyle,),
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
                          return const Text('error');
                         }
                           
                         }
                       ),
                     ),
                            ]),) ,
        
                      SliverToBoxAdapter(
                        child: Padding(
                         padding: const EdgeInsets.only(right: 15,left: 15,top:30,bottom: 5),
                         child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(AppLocalizations.of(context)!.top_sales,style: AppTextStyle.blackTitleTextStyle,),Text(AppLocalizations.of(context)!.see_all,style: AppTextStyle.hintTextStyle,),
                                ]),
                                     ),
                      ) ,
                         SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250.h,
                    child: GetBuilder<ProductController>(
                      init:ProductController(),
                      builder:(productController)=> FutureBuilder(
                        future: productController.getSortedProducts(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){ 
                            return ListView.builder(
                            padding:const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: productController.sortedProducts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                
                                child: ProductItem(image:productController.sortedProducts[index].image,
                                name:productController.sortedProducts[index].name ,
                                price: productController.sortedProducts[index].price,
                                promo:productController.sortedProducts[index].promotion ,
                                id:productController.sortedProducts[index].id! ,
                                rating: productController.sortedProducts[index].rate,
                                ),
                              );
                            },
                          );
                          }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                  return const Center(child:CircularProgressIndicator());
        
                          }else{
                          return const Text('error');
                         }             
                        }
                      ),
                    ),
                  ),
                ),
                 SliverToBoxAdapter(
                        child: Padding(
                         padding: const EdgeInsets.only(right: 15,left: 15,top:15,bottom: 5),
                         child: Text(AppLocalizations.of(context)!.categories,style: AppTextStyle.blackTitleTextStyle,),
                                     ),
                      ) ,
                        SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40.h,
                    child: GetBuilder<CategoryController>(
                      init:CategoryController(),
                      builder:(categoryController)=> FutureBuilder(
                        future: categoryController.getAllCategories(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){ 
                            return GetBuilder<CategoryController>(
                                              init:CategoryController(),
                      id:ControllerID.SELECT_CATEGORY,
        
                              builder: (controller) {
                                return ListView.builder(
                                padding:const EdgeInsets.symmetric(horizontal:12,vertical: 5),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.categoriesList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                    child: GestureDetector(
                                      onTap:(){
                                        controller.selectCategory(controller.categoriesList[index]);
                                      },
                                      child: Container(
                                        decoration:controller.selectedCategory.id==controller.categoriesList[index].id? BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius:BorderRadius.circular(20)
                                        ):BoxDecoration(
                                          color: AppColors.backgroundWhite,
                                          borderRadius:BorderRadius.circular(20),
                                          border:  Border.all(
                                          color: AppColors.secondary, 
                                          width: 2,
                                        ),
                                        ) ,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:15,vertical: 8.0),
                                          child: Text( controller.categoriesList[index].title,style:
                                          controller.selectedCategory.id==controller.categoriesList[index].id?
                                           AppTextStyle.smallDarkButtonTextStyle:  AppTextStyle.smallLightButtonTextStyle,),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                          );
                              }
                            );
                          }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                  return const Center(child:CircularProgressIndicator());
        
                          }else{
                          return const Text('error');
                         }             
                        }
                      ),
                    ),
                  ),
                ),
               SliverToBoxAdapter(
                  child: GetBuilder<CategoryController>(
                                    init:CategoryController(),
                      id:ControllerID.SELECT_CATEGORY,
        
                    builder: (categoryctrl) {
                      return GetBuilder<ProductController>(
                        init:ProductController(),
                        builder: (productController) {
                          return FutureBuilder(
                            future: productController.getProductsByCategory(categoryctrl.selectedCategory.id),
                            builder: (context, snapshot) {
                              
                            if(snapshot.hasData){
        
                              return MasonryGridView.count(
                                                      padding:const  EdgeInsets.symmetric(horizontal:15,vertical: 10),
        
                              //  scrollDirection: Axis.vertical,
                                crossAxisSpacing: 10,
                                crossAxisCount:2,      
                                mainAxisSpacing:10,             
                                itemBuilder: (context,index)=> SizedBox(
                                  //  height:  50,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(15),
                                      child: Image.network(productController.productsByCategory[index].image,fit: BoxFit.cover,)),
                                  ),
                                  itemCount: productController.productsByCategory.length,
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: false,
                                  physics:const NeverScrollableScrollPhysics(),
        
                              );
                          }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                      return const Center(child:CircularProgressIndicator());
        
                              }else{
                              return const Text('error');
                             }             
        
        
                            }
                          );
                        }
                      );
                    }
                  ),
                )
                  
                  ////////////////////////////////////////////
        
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
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
                  child: Builder(
                    builder: (context) {
                      return GetBuilder<ProductController>(
                        init: ProductController(),
                        builder: (prdController) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                               SearchInput(controller: prdController.searchController,onChanged: (v){
                                prdController.filterProducts(v);
                              },),
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
                          );
                        }
                      );
                    }
                  ),
                ),
              ),
              ),      
        
         SliverToBoxAdapter(
                  child:
                            MasonryGridView.count(
                                                      padding:const  EdgeInsets.symmetric(horizontal:15,vertical: 10),
        
                              //  scrollDirection: Axis.vertical,
                                crossAxisSpacing: 10,
                                crossAxisCount:2,      
                                mainAxisSpacing:10,             
                                itemBuilder: (context,index)=> SizedBox(
                                  //  height:  50,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(15),
                                      child: Image.network(pc.filtredProducts[index].image,fit: BoxFit.cover,)),
                                  ),
                                  itemCount: pc.filtredProducts.length,
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: false,
                                  physics:const NeverScrollableScrollPhysics(),
        
                              )
                       
                    
                
                )
                ]
              );
            }
          ),
        ),
      ),
    );
  }
}