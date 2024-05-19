import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/screens/payment/payment_method_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/UI/widgets/input.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/payment_controller.dart';

class PaymentAddressScreen extends StatefulWidget {
  const PaymentAddressScreen({super.key});

  @override
  State<PaymentAddressScreen> createState() => _PaymentAddressScreenState();
}
late  TextEditingController address;
late  TextEditingController gov;
late  TextEditingController ville;
late  TextEditingController code;
late  TextEditingController phone;

  final _formKey = GlobalKey<FormState>();

class _PaymentAddressScreenState extends State<PaymentAddressScreen> {
@override
  void initState() {
    AuthenticationController authenticationController=Get.find();
    address=TextEditingController();
    gov=TextEditingController();
    gov.text=authenticationController.currentUser.address!;
    ville=TextEditingController();
    code=TextEditingController();
    phone=TextEditingController();
    phone.text=authenticationController.currentUser.phone;
    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    gov.dispose();
    ville.dispose();
    code.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
                SliverAppBar(
                  title: Text('Adresse de livraison',style: AppTextStyle.blackTitleTextStyle,),
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
                                child: Form(
                                  key:_formKey,
                                  child: Column(
                                    children: [
                                      InputText(hint: 'Address',controler: address,validator: (v){
                                        if(v!.isEmpty){
                                          return 'adresse obligatoir';
                                        }
                                        return null;
                                      },),
                                      const SizedBox(height:20),
                                      InputText(hint: 'Gouvernorat',controler: gov,
                                      validator: (v){
                                        if(v!.isEmpty){
                                          return 'Gouvernorat obligatoir';
                                        }
                                        return null;
                                      },),
                                      const SizedBox(height:20),
                                      InputText(hint: 'Ville',controler: ville,
                                       validator: (v){
                                        if(v!.isEmpty){
                                          return 'ville obligatoir';
                                        }
                                        return null;
                                      },),
                                        const SizedBox(height:20),
                                      InputText(hint: 'Code Postal',type: TextInputType.number,length: 4,controler: code,
                                       validator: (v){
                                        if(v!.length!=4){
                                          return 'code postal invalid';
                                        }
                                        return null;
                                      },),
                                        const SizedBox(height:20),
                                      InputText(hint: 'Numéro de téléphone',type: TextInputType.number,length: 8,controler: phone,
                                       validator: (v){
                                        if(v!.isEmpty){
                                          return 'Numéro de téléphone invalid';
                                        }
                                        return null;
                                      },),
                                            const SizedBox(height:40),
                                          MyButton(text: 'Continue', click: (){
                                             if(_formKey.currentState!.validate()){
                                              controller.getUserAddress(address.text, gov.text, ville.text, code.text, phone.text);
                                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentMethodScreen()));
                                            }
                                       })

                                    ],
                                  ),
                                ),
                              ),
                            )
            ],
          );
        }
      ),
    )
    );
  }
}