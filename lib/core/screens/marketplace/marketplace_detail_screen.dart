import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_event.dart';
import 'package:leafolyze/blocs/shop/shop_state.dart';
import 'package:leafolyze/utils/constants.dart';

class MarketplaceDetailScreen extends StatefulWidget {
  final int shopId;

  const MarketplaceDetailScreen({super.key, required this.shopId});

  @override
  State<MarketplaceDetailScreen> createState() =>
      _MarketplaceDetailScreenState();
}

class _MarketplaceDetailScreenState extends State<MarketplaceDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the bloc to load the shop details
    context.read<ShopBloc>().add(LoadShops(widget.shopId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ShopError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ShopBloc>().add(LoadShops(widget.shopId)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ShopLoaded) {
            final shop = state.shop;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    shop.name,
                    style: const TextStyle(
                      fontSize: AppFontSize.fontSizeXXL,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                  floating: true,
                  snap: true,
                  pinned: true,
                  backgroundColor: AppColors.backgroundColor,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacingM,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: AppSpacing.spacingL),
                      // Store Name
                      Text(
                        shop.name,
                        style: const TextStyle(
                          fontSize: AppFontSize.fontSizeL,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingM),
                      // Store Image and Details
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Store Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                AppBorderRadius.radiusXS),
                            child: Image.network(
                              shop.image as String? ?? 'https://lh3.googleusercontent.com/p/AF1QipMd6Q5zYhf4MX9GCK3nEblqaBHmCIpQSH446pwh=s1360-w1360-h1020',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.spacingM),
                          // Store Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lokasi',
                                  style: TextStyle(
                                    color: AppColors.textMutedColor,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                Text(
                                  shop.address,
                                  style: const TextStyle(
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.spacingS),
                                const Text(
                                  'Jam Operasional',
                                  style: TextStyle(
                                    color: AppColors.textMutedColor,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                Text(
                                  shop.operational,
                                  style: const TextStyle(
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.spacingS),
                                const Text(
                                  'Tanggal Bergabung',
                                  style: TextStyle(
                                    color: AppColors.textMutedColor,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                Text(
                                  shop.createdAt != null
                                      ? '${shop.createdAt!.day}/${shop.createdAt!.month}/${shop.createdAt!.year}'
                                      : 'Unknown',
                                  style: const TextStyle(
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.spacingM),
                      // Store Description
                      const Text(
                        'Deskripsi Toko',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeM,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingXS),
                      Text(shop.description),
                      const SizedBox(height: AppSpacing.spacingM),
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeM,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingXS),
                      // Google Maps
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text('Google Maps will be integrated here'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
