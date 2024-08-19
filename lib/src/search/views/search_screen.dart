import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/utils/logger.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/email_textfield.dart';
import 'package:fashon_shop/common/widgets/empty_screen_widget.dart';
import 'package:fashon_shop/common/widgets/login_bottom_sheet.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/src/products/widgets/staggered_tile_widget.dart';
import 'package:fashon_shop/src/search/controllers/search_notifier.dart';
import 'package:fashon_shop/src/whishlist/controllers/whishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? accessToken = Storage().getString('accessToken');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clearResults();
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: EmailTextField(
              controller: _searchController,
              radius: 30,
              hintText: AppText.kSearchHint,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context.read<SearchNotifier>().searchFunction(_searchController.text);
                  } else {
                    TLoggerHelper.debug('SEARCH KEY IS EMPTY');
                  }
                },
                child: const Icon(AntDesign.search1, color: Kolors.kPrimary),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, chils) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                searchNotifier.results.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: AppText.kSearchResults,
                            style: appStyle(
                              13,
                              Kolors.kPrimary,
                              FontWeight.w600,
                            ),
                          ),
                          ReusableText(
                            text: searchNotifier.searchKey,
                            style: appStyle(
                              13,
                              Kolors.kPrimary,
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 10.h,
                ),
                searchNotifier.results.isNotEmpty
                    ? StaggeredGrid.count(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        crossAxisCount: 4,
                        children: List.generate(searchNotifier.results.length, (index) {
                          final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
                          final product = searchNotifier.results[index];
                          return StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: mainAxisCellCount,
                            child: StaggeredTileWidget(
                              i: index,
                              product: product,
                              onTap: () {
                                if (accessToken == null) {
                                  loginBottomSheet(context);
                                } else {
                                  context.read<WhishlistNotifier>().addRemoveWhishlist(product.id, () {});
                                }
                              },
                            ),
                          );
                        }),
                      )
                    : const EmptyScreenWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
