import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rohan_test/screens/product_home_controller.dart';
import 'package:rohan_test/widgets/horizontal_listView.dart';
import 'package:rohan_test/widgets/loading_progres_bar.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  ProductHomeController productHomeController = Get.put(ProductHomeController());
  ScrollController scrollController = ScrollController();
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await productHomeController.getListOfCategoryApiCall(pageIndex: 1);
        await productHomeController.getListOfSubCategoryApiCall(pageIndex: 1);
      },
    );
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && productHomeController.isMoreSubData) {
        pageIndex++;
        productHomeController.getListOfSubCategoryApiCall(pageIndex: pageIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productHomeController.isLoading.value) {
        return Scaffold(
          body: Center(child: LoadingProgressBar()),
        );
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            /// filter
            const Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            ///search
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: mainCategoryList(),
          ),
        ),
        body: Obx(() {
          /// main vertical list view
          return ListView.builder(
            controller: scrollController,
            itemCount: productHomeController.subCategoriesList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HorizontalListview(
                      subCategoryName: productHomeController.subCategoriesList[index].name ?? '',
                      product: productHomeController.subCategoriesList[index].product,
                      subIndex: index,
                        subCategoryId:productHomeController.subCategoriesList[index].id??0,
                    ),
                  ),
                  if(productHomeController.isMoreSubData && index +1 ==productHomeController.subCategoriesList.length)
                    const Center(child: CircularProgressIndicator(),)
                ],
              );
            },
          );
        }),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }

  Widget mainCategoryList() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: productHomeController.categoryList.result?.category?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                productHomeController.categoryList.result?.category?[index].name ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: index == 1 ? 14 : 13,
                  fontWeight: index == 1 ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
