import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rohan_test/consts/api_keys.dart';

import 'package:rohan_test/consts/api_urls.dart';
import 'package:rohan_test/networks/network_function.dart';
import 'package:rohan_test/screens/models/category_list_model.dart';
import 'package:rohan_test/screens/models/product_list_model.dart' as product_list;

class ProductHomeController extends GetxController {
  CategoryListModel categoryList = CategoryListModel();
  RxList<SubCategories> subCategoriesList = <SubCategories>[].obs;
  List<product_list.Result> productsList = <product_list.Result>[];
  RxBool isLoading = true.obs;
  bool isMoreSubData = true;

  /// to get list of mainCategories
  Future<void> getListOfCategoryApiCall({
    int pageIndex = 1,
  }) async {
    final data = {
      ApiKeys.categoryId: 0,
      ApiKeys.deviceManufacturer: "Google",
      ApiKeys.deviceModel: "Android SDK built for x86",
      ApiKeys.deviceToken: " ",
      ApiKeys.pageIndex: pageIndex,
    };

    http.Response response = await NetworkFunctions.postApiRequest(
      ApiUrls.dashBoard,
      data: data,
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      categoryList = categoryListModelFromJson(response.body);
    } else {}
  }

  /// to get list of subCategories
  Future<void> getListOfSubCategoryApiCall({
    int pageIndex = 1,
  }) async {
    isLoading.value = (pageIndex == 1);
    try {
      final data = {
        ApiKeys.categoryId: 56,
        ApiKeys.pageIndex: pageIndex,
      };
      debugPrint('VERTICAL LIST CALLING');
    debugPrint(data.toString());
      http.Response response = await NetworkFunctions.postApiRequest(
        ApiUrls.dashBoard,
        data: data,
      );


      debugPrint(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CategoryListModel subcategoryListModel = categoryListModelFromJson(response.body);
        subCategoriesList.addAll(subcategoryListModel.result?.category?.first.subCategories ?? []);
        if (subcategoryListModel.result?.category?.first.subCategories?.isEmpty == true || (subcategoryListModel.result?.category?.first.subCategories?.length ?? 0) < 5) {
          isMoreSubData = false;
        }
      } else {}
    } finally {
      isLoading.value = false;
    }
  }


/// to get list of products
  Future<void> getListOfProductsApiCall({
    int pageIndex = 1,
    required int subIndex,
    required int subCategoryId,
  }) async {
    try {
      final data = {
        ApiKeys.pageIndex: pageIndex,
        ApiKeys.subCategoryId: subCategoryId,
      };
      debugPrint('----------PRODUCT LIST--------');
      debugPrint(data.toString());
      http.Response response = await NetworkFunctions.postApiRequest(
        ApiUrls.productList,
        data: data,
      );


      debugPrint(data.toString());
      debugPrint(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        product_list.ProductListModel subcategoryListModel = product_list.productListModelFromJson(response.body);

        subCategoriesList[subIndex].product?.addAll(subcategoryListModel.result?.map(
              (e) {
                return Product(priceCode: e.priceCode, name: e.name, imageName: e.imageName, id: e.id);
              },
            ).toList() ??
            []);
      } else {}
    } finally {
    }
  }
}
