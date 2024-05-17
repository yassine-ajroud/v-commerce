import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/category_item.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: CustomScrollView(
        slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading:GetBuilder(
                      init: MyDrawerController(),
                      builder: (drawerController) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: (){
                              drawerController.toggleDrawer();
                            },
                            child: SvgPicture.string(APPSVG.menuIcon)),
                        );
                      }
                    ) ,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
               shadowColor: Colors.grey,
                      actions: [IconButton(onPressed: (){}, icon: SvgPicture.string(APPSVG.cartIcon))],
                      expandedHeight: 133.h,
                      pinned: true,
                      floating: true,
                      snap: true,
                      flexibleSpace:FlexibleSpaceBar(
                background: Padding(
                      padding: const EdgeInsets.symmetric(vertical:20,horizontal: 15),
                  child: Builder(
                    builder: (ctx) {
                      return GetBuilder<CategoryController>(
                        init: CategoryController(),
                        builder: (controller) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                               SearchInput(controller: controller.searchController,onChanged: (v){
                                controller.filterCategories(v);
                                print(controller.filtredCategoriesList);
                              },),

                            
                            ],
                          );
                        }
                      );
                    }
                  ),
                ),
              ),
              ),   
              SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
              sliver:GetBuilder(
                  init: CategoryController(),
                  id: ControllerID.CATEGORY_FILTER,
                  builder: (controller) {
                    return SliverGrid(
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.8,
                          ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CategoryItem(category: controller.filtredCategoriesList[index]);
                      },
                      childCount: controller.filtredCategoriesList.length,
                    ),
                    );
                  }
                ) ,
) ,
    const  SliverToBoxAdapter(
                    child: SizedBox(height: 90),
                  )
                
                              
        ],
      ),
    ));
  }
}