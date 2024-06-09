import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rohan_test/screens/models/category_list_model.dart';
import 'package:rohan_test/screens/product_home_controller.dart';

class HorizontalListview extends StatefulWidget {
  final String subCategoryName;
  final List<Product>? product;
  final int subIndex;
  final int subCategoryId;

  const HorizontalListview({
    super.key,
    required this.subCategoryName,
    this.product,
    required this.subIndex,
    required this.subCategoryId,
  });

  @override
  State<HorizontalListview> createState() => _HorizontalListviewState();
}

class _HorizontalListviewState extends State<HorizontalListview> {
  final ScrollController _scrollController = ScrollController();
  ProductHomeController productHomeController = Get.find<ProductHomeController>();
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageIndex++;
        productHomeController.getListOfProductsApiCall(
          pageIndex: pageIndex,
          subIndex: widget.subIndex,
            subCategoryId:widget.subCategoryId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// subCategoryName
        Text(
          widget.subCategoryName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 160,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.product?.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        /// Image
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            height: 70,
                            width: 100,
                            widget.product?[index].imageName ?? '',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        /// priceCode
                        Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(3)),
                          child: Text(widget.product?[index].priceCode??'',style: const TextStyle(color: Colors.white,fontSize: 10),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    /// productName
                    Text(widget.product?[index].name ?? '',maxLines: 3,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
