import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/main/main_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/UI/widgets/input.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';
import 'package:v_commerce/presentation/controllers/payment_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentOnlineScreen extends StatefulWidget {
  const PaymentOnlineScreen({super.key});

  @override
  State<PaymentOnlineScreen> createState() => _PaymentOnlineScreenState();
}
 late TextEditingController cardnb;
 late TextEditingController code;
  late TextEditingController name;
  final _formKey = GlobalKey<FormState>();


class _PaymentOnlineScreenState extends State<PaymentOnlineScreen> {
@override
  void initState() {
    cardnb=TextEditingController();
    code=TextEditingController();
    name=TextEditingController();
    super.initState();
  }
@override
  void dispose() {
   cardnb.dispose();
   code.dispose();
   name.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
                  SliverAppBar(
                    actions: [ Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15.0),
                      child: SvgPicture.string(APPSVG.securityIcon),
                    )],
                      title: Text(AppLocalizations.of(context)!.pay_online,style: AppTextStyle.appBarTextButtonStyle,),
                      centerTitle: true,
                                    automaticallyImplyLeading: false,
                                    leading:IconButton(
                              onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            
                            padding: EdgeInsets.zero,
                            icon:const Icon(Icons.arrow_back,size: 30,)) ,
                                    backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.white,
                               shadowColor: Colors.grey,
                                      pinned: true,
                                      floating: true,
                                      snap: true,
                              ),  

                              SliverToBoxAdapter(child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset("assets/images/visa.png",width: 50.w,fit: BoxFit.cover,),
                                         Image.asset("assets/images/poste.png",width: 50.w,fit: BoxFit.cover,),
                                          Image.asset("assets/images/mastercard.png",width: 50.w,fit: BoxFit.cover,)
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Text(AppLocalizations.of(context)!.card_number,style: AppTextStyle.blackTextStyle,),
                                    const SizedBox(height: 10,),
                                    InputText(hint: "**** **** **** ****",type: TextInputType.number,length: 16,isPassword: true,validator: (v){
                                      if(!controller.validCardNumber(v!)||v.length!=16){
                                        return AppLocalizations.of(context)!.card_number_required;
                                      }return null;
                                      
                                    },),
                                    const SizedBox(height: 20,),
                                    Text(AppLocalizations.of(context)!.expiration_date,style: AppTextStyle.blackTextStyle,),
                                                                        const SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

   SizedBox(
    width: 150.w,
     child: DropdownButtonFormField(
          decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:  BorderRadius.all(
                         Radius.circular(30.0),
                        
                      ),
                    ),
                    filled: true,
                    hintText: "Mois",
                    fillColor:AppColors.lightgrey),
                // Initial Value
                value: controller.month,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: ['1', '2', '3', '4','5','6','7','8','9','10','11','12'].map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
               controller.setMonth(newValue!);
                  
                },
              ),
   ),

   SizedBox(
    width: 150.w,
     child: DropdownButtonFormField(
          decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:  BorderRadius.all(
                         Radius.circular(30.0),
                        
                      ),
                    ),
                    filled: true,
                    hintText: "Année",
                    fillColor:AppColors.lightgrey),
                // Initial Value
                value: controller.year,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: ['2024', '2025', '2027', '2028','2029','2030'].map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
               controller.setYear(newValue!);
                  
                },
              ),
   ),

                                    ],),
                                     const SizedBox(height: 20,),
                                    Text(AppLocalizations.of(context)!.security_code,style: AppTextStyle.blackTextStyle,),
                                    const SizedBox(height: 10,),
                                    InputText(hint: "***",length: 3,type: TextInputType.number,isPassword: true,validator: (v){
                                      if(!controller.validCardNumber(v!)||v.length!=3){
                                        return AppLocalizations.of(context)!.code_invalid;
                                      }return null;
                                      
                                    },),
 const SizedBox(height: 20,),
                                    Text(AppLocalizations.of(context)!.name_of_the_holder,style: AppTextStyle.blackTextStyle,),
                                    const SizedBox(height: 10,),
                                    InputText(hint: AppLocalizations.of(context)!.first_last_name, validator: (v){
                                      if(v!.isEmpty){
                                        return AppLocalizations.of(context)!.first_name_required;
                                      }return null;
                                      
                                    },),                                     const SizedBox(height: 40,),

                                                         MyButton(text: "${AppLocalizations.of(context)!.pay} ${cartController.totalPrice}${AppLocalizations.of(context)!.dinar}", click: ()async{
                                                          if(_formKey.currentState!.validate()){
                                                          //  final date = DateTime.now();
                                                              final res=  await controller.createOrder();
                                             if(res){
                                              Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.order_added,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
                                             }
                                             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const MainScreen()));
                                                           
                                                          }

                                                         }) 
                                  ],),
                                ),
                              ),)
            ],
          );
        }
      ),
    ));
  }
}