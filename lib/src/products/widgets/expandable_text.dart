import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.justify,
          maxLines: controller.description ? 10 : 3,
          style: appStyle(13, Kolors.kGray, FontWeight.normal),
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                controller.setDescription(!controller.description);
              },
              child: Text(
                controller.description ? 'Read Less' : 'Read More',
                style: appStyle(11, Kolors.kPrimaryLight, FontWeight.normal),
              ),
            )
          ],
        ),
      ],
    );
  }
}
