import 'package:example/CategoryScreen/Category_model.dart';
import 'package:example/Consts/textStyle_consts.dart';
import 'package:example/ProductsScreen/ProductsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            maintainState: false,
            builder: (context) =>
                ProductsScreen(category: category),
          ),
        );
      },
      child: Container(
        width: 343,
        height: 84,
        margin: EdgeInsets.only(left: 16, right: 16, top: 10),
        decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(8),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [Text(category.name, style: AllTextStyles.CategoryTitleTextStyle)],
              ),
            ),
            Container(
              width: 100,
              height: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image(
                  image:
                      NetworkImage("https://api.doover.tech${category.picture}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
