import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/service.dart';
import 'package:v_commerce/domain/entities/user.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/get_user_usecase.dart';
import 'package:v_commerce/domain/usecases/service_usecases/add_service_image_usecase.dart';
import 'package:v_commerce/domain/usecases/service_usecases/get_all_services_usecase.dart';
import 'package:v_commerce/domain/usecases/service_usecases/get_service_by_id_usecase.dart';
import 'package:v_commerce/domain/usecases/service_usecases/get_service_by_user_id.dart';
import 'package:v_commerce/domain/usecases/service_usecases/update_service_image_usecase.dart';
import 'package:v_commerce/domain/usecases/service_usecases/update_service_usecase.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';

class ServiceController extends GetxController{
  late MyService currentUserService;
  int serviceImagesindex= 0;
  List<MyService> allServices=[];
  List<MyService> filtredServices=[];
  List<User> users=[];
  String selectedServiceCategory='';
  String selectedServiceId='';
  late MyService selectedService;
  late User selectedUser;

   TextEditingController searchController = TextEditingController(); 

  Future<MyService> getCurrentService()async{
    print('get $selectedServiceId');
    final res = await GetServiceByIdUsecase(sl())(selectedServiceId);
    res.fold((l) => null, (r) async{
      return selectedService=r;
    });
          final res1 = await GetUserUsecase(sl())(selectedService.userId);
      res1.fold((l) => null, (r) => selectedUser=r);
    return selectedService;
  }

  Future<MyService> getCurrentUserService()async{
    AuthenticationController authenticationController=Get.find();
    final res = await GetServiceByUserIdUsecase(sl())(authenticationController.currentUser.id!);
    res.fold((l) => null, (r) => currentUserService=r);
    return currentUserService;
  }

  void setImageIndex(int index){
    serviceImagesindex=index;
    update();
  }

  Future<MyService> updateService(MyService newService)async{
   final res =await UpdateServiceUsecase(sl())(newService);
   res.fold((l) => null, (r) => currentUserService=r);
   return currentUserService;
}

Future<List<MyService>> getAllServices()async{
  final res = await GetAllServicesUsecase(sl())(selectedServiceCategory);
  res.fold((l) => null, (r) {
    filtredServices=r;
    return allServices=r;
  });
  await getUsers();
 return allServices;
}

Future getUsers()async{
  users=[];
for (var element in allServices) {
   final res=await GetUserUsecase(sl())(element.userId);
   res.fold((l) => null, (r) => users.add(r));
}
}

void filterService(String word){
    filtredServices= allServices.where((element) {
      User user = users.firstWhere((elem) => elem.id==element.userId);
      return (user.firstName.toUpperCase().contains(word.toUpperCase())||user.lastName.toUpperCase().contains(word.toUpperCase())||user.address!.toUpperCase().contains(word.toUpperCase()));
    }).toList();
  
    update([ControllerID.SERVICE_FILTER]);
}

XFile? img,updateimg;
  File? f,updatef;
  final ImagePicker _picker = ImagePicker();
  String fileName = '';
  String updatefileName = '';
  
  Future<void> pickImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              'Upload image',
              style: AppTextStyle.blackTitleTextStyle,
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () async {
                          img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
                                     if(f!=null){
                            await AddServiceImageUsecase(sl())(serviceId: currentUserService.id!,file: f!);
                            update();
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                    IconButton(
                        onPressed: () async {
                          img = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
                          if(f!=null){
                            await AddServiceImageUsecase(sl())(serviceId: currentUserService.id!,file: f!);
                            update();
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                  ]),
            ),
          ),
        );
      },
    );
  }
Future<void> updateImage(BuildContext context,String oldImage)async{
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              'Upload image',
              style: AppTextStyle.blackTitleTextStyle,
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () async {
                          updateimg = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (updateimg != null) {
                            updatef = File(updateimg!.path);
                            updatefileName = basename(updatef!.path);
                          update();
                          }
                         
                                         if(updatef!=null){
                            await UpdateServiceImageUsecase(sl())(serviceId: currentUserService.id!,file: updatef!,oldImage: oldImage);
                            update();
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                    IconButton(
                        onPressed: () async {
                          updateimg = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (updateimg != null) {
                            updatef = File(updateimg!.path);
                            updatefileName = basename(updatef!.path);
                          update();
                          }
                          if(updatef!=null){
                            await UpdateServiceImageUsecase(sl())(serviceId: currentUserService.id!,file: updatef!,oldImage: oldImage);
                            update();
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                  ]),
            ),
          ),
        );
      },
    );
}
Future removeImage(String img)async{
  currentUserService.images.remove(img);
  await UpdateServiceUsecase(sl())(currentUserService);
  update();

}

}