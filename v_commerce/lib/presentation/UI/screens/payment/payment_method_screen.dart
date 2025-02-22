import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/enums.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/main/main_screen.dart';
import 'package:v_commerce/presentation/UI/screens/payment/payment_online_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/UI/widgets/payment_method_item.dart';
import 'package:v_commerce/presentation/controllers/payment_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body:GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
                SliverAppBar(
                  title: Text(AppLocalizations.of(context)!.payment_method,style: AppTextStyle.appBarTextButtonStyle,),
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

                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    PaymentMethodItem(method: PaymentMethod.cash, icon: APPSVG.cashIcon, label: AppLocalizations.of(context)!.cash_on_delivery),
                                const Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.0),
                child:  Divider(),
              ),
                                    PaymentMethodItem(method: PaymentMethod.digital, icon: APPSVG.payementCard, label: AppLocalizations.of(context)!.online_payment),

                                          const SizedBox(height:60),
                                        MyButton(text: AppLocalizations.of(context)!.next, click: ()async{
                
                                            if(controller.paymentMethod==PaymentMethod.cash){
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
                                                                                         
                                            }else{
                                             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentOnlineScreen()));

                                            }
                                          
                                     })

                                  ],
                                ),
                              ),
                            )
            ],
          );
        }
      ), 

    ));
  }
}