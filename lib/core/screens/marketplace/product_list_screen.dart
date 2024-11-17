import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_bloc.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_event.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_state.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/core/widgets/marketplace/detailed_product_card.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/utils/string_utils.dart';

class ProductListScreen extends StatefulWidget {
  final String productType;

  const ProductListScreen({super.key, required this.productType});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late String deslugifiedType;
  String? selectedSortOption = 'Recently Added';

  @override
  void initState() {
    super.initState();
    deslugifiedType = deslugify(widget.productType);
    context.read<MarketplaceBloc>().add(LoadProductsByType(widget.productType));
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBorderRadius.radiusS)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Sort By',
                style: TextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.textMutedColor,
                ),
              ),
            ),
            RadioListTile<String>(
              title: const Text('Recently Added'),
              value: 'Recently Added',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: Low to High'),
              value: 'Price: Low to High',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: High to Low'),
              value: 'Price: High to Low',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Top Rated'),
              value: 'Top Rated',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false,
            ),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.backgroundColor,
                centerTitle: true,
                title: Text(
                  deslugifiedType,
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeXXL,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                floating: true,
                snap: true,
                pinned: true,
                expandedHeight: 80,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacingM,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    CustomSearchBar(
                      // TODO: Implement search functionality
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    ),
                    SizedBox(height: AppSpacing.spacingM),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showSortOptions(context);
                            },
                            icon: const Icon(
                              Icons.sort,
                              color: AppColors.textColor,
                              size: AppIconSize.iconS,
                            ),
                            label: Text(
                              'Sort By',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: AppFontSize.fontSizeMS,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.spacingXS),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Implementasi "Filter"
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              color: AppColors.textColor,
                              size: AppIconSize.iconS,
                            ),
                            label: const Text(
                              'Filter',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: AppFontSize.fontSizeMS,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacingM,
                  vertical: AppSpacing.spacingM,
                ),
                sliver: state is MarketplaceLoading
                    ? const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : state is MarketplaceLoaded
                        ? state.products.isEmpty
                            ? SliverFillRemaining(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.inventory_2_outlined,
                                        size: 64,
                                        color: AppColors.textMutedColor,
                                      ),
                                      SizedBox(height: AppSpacing.spacingS),
                                      Text(
                                        'No products available for ${deslugifiedType}',
                                        style: TextStyle(
                                          color: AppColors.textMutedColor,
                                          fontSize: AppFontSize.fontSizeL,
                                          fontWeight: AppFontWeight.medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.63,
                                  mainAxisSpacing: AppSpacing.spacingMS,
                                  crossAxisSpacing: AppSpacing.spacingMS,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final product = state.products[index];
                                    return DetailedProductCard(
                                        product: product);
                                  },
                                  childCount: state.products.length,
                                ),
                              )
                        : state is MarketplaceError
                            ? SliverFillRemaining(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        size: 64,
                                        color: AppColors.errorColor,
                                      ),
                                      SizedBox(height: AppSpacing.spacingS),
                                      Text(
                                        state.message,
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: AppFontSize.fontSizeL,
                                          fontWeight: AppFontWeight.medium,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: AppSpacing.spacingM),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context.read<MarketplaceBloc>().add(
                                              LoadProductsByType(
                                                  deslugifiedType));
                                        },
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('Try Again'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SliverFillRemaining(
                                child: Center(
                                  child: Text('Something went wrong'),
                                ),
                              ),
              ),
            ],
          );
        },
      ),
    );
  }
}
