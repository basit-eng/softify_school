import 'package:flutter/material.dart';
import 'package:softify/model/home/ManufacturersResponse.dart';
import 'package:softify/utils/GetBy.dart';
import 'package:softify/views/customWidget/cached_image.dart';
import 'package:softify/views/pages/product-list/product_list_screen.dart';

class ManufacturerBox extends StatelessWidget {
  final ManufacturerData manufacturerData;

  ManufacturerBox(this.manufacturerData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 150,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductListScreen.routeName,
                arguments: ProductListScreenArguments(
                  id: manufacturerData.id,
                  name: manufacturerData.name,
                  type: GetBy.MANUFACTURER,
                ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: CpImage(
              url: manufacturerData.pictureModel.imageUrl,
              fit: BoxFit.contain, // BoxFit.cover == CenterCrop
            ),
          ),
        ),
      ),
    );
  }
}
