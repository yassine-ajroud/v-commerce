import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/supplier.dart';
import 'package:v_commerce/domain/usecases/supplier_usecases/get_supplier_by_ud_usecase.dart';

class SupplierController extends GetxController{
 late Supplier currentSupplier;
  

  Future<Supplier?> getSupplierById(String supplierId)async{
   final res= await GetSupplierByIdUsecase(sl())(supplierId);
   res.fold((l) => null, (r) => currentSupplier=r );
   return currentSupplier;
  }
}