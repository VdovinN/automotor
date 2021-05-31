import 'package:automotor/screen/onboarding/component/catalog/search/search_field.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  static String routeName = "/catalog";

  const CatalogPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: SearchField(),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
