import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/product.dart';
import 'package:v_commerce/presentation/UI/widgets/products_item.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';

// ignore: must_be_immutable
class FilteredProductScreen extends StatefulWidget {
  List<Product> products=[];
   FilteredProductScreen({super.key,required this.products});

  @override
  State<FilteredProductScreen> createState() => _FilteredProductScreenState();
}
late  TextEditingController  editingController;
List<Product> filteredList=[];

class _FilteredProductScreenState extends State<FilteredProductScreen> {
  @override
  void initState() {
    editingController = TextEditingController();
    filteredList=widget.products;
    super.initState();
  }
  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    backgroundColor: AppColors.backgroundWhite,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                        automaticallyImplyLeading: false,
                      
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                   shadowColor: Colors.grey,
                          actions: [IconButton(onPressed: (){}, icon: SvgPicture.string(APPSVG.cartIcon))],
                          expandedHeight: 133.h,
                          pinned: true,
                          floating: true,
                          snap: true,
                          leading:IconButton(
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    padding: EdgeInsets.zero,
                    icon:const Icon(Icons.arrow_back,size: 30,)) ,
                          flexibleSpace:FlexibleSpaceBar(
                    background: Padding(
                          padding: const EdgeInsets.symmetric(vertical:20,horizontal: 15),
                      child: Builder(
                        builder: (ctx) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                   SearchInput(controller:editingController,onChanged: (v){
                                    setState(() {
                                      filteredList=widget.products.where((element) => element.name.toUpperCase().contains(v.toUpperCase())||element.description.toUpperCase().contains(v.toUpperCase())).toList();
                                    });
                                  },),
      
                                
                                ],
                              );
                            
                        }
                      ),
                    ),
                  ),
                  ),   
      
                    SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                  sliver:
                         SliverGrid(
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.6,
                              ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ProductItem(image: filteredList[index].image, name:  filteredList[index].name, price:  filteredList[index].price, id:  filteredList[index].id!, rating:  filteredList[index].rate);
                          },
                          childCount: filteredList.length,
                        ),
                        )
                      
           
      ) ,
          ],
        ),
      ),
    );
  }
}