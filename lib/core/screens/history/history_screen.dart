// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leafolyze/blocs/history/history_bloc.dart';
// import 'package:leafolyze/blocs/history/history_state.dart';
// import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
// import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
// import 'package:leafolyze/utils/constants.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         shrinkWrap: true,
//         scrollBehavior: const ScrollBehavior().copyWith(
//           overscroll: false,
//         ),
//         slivers: [
//           SliverAppBar(
//             centerTitle: true,
//             title: const Text(
//               'History',
//               style: TextStyle(
//                 fontSize: AppFontSize.fontSizeXXL,
//                 fontWeight: AppFontWeight.semiBold,
//               ),
//             ),
//             floating: true,
//             snap: true,
//             pinned: true,
//             expandedHeight: 80,
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
//               child: Column(
//                 children: [
//                   CustomSearchBar(
//                     onChanged: (value) {
//                       // You can trigger search functionality if needed
//                     },
//                     onSubmitted: (value) {

//                     },
//                   ),
//                   const SizedBox(height: AppSpacing.spacingM),
//                   BlocBuilder<GambarMLBloc, GambarMLState>(
//                     builder: (context, state) {
//                       if (state is GambarMLLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (state is GambarMLLoaded) {
//                         final data = state.gambarMLList;
//                         if (data.isEmpty) {
//                           return const Center(
//                             child: Text('No history available'),
//                           );
//                         }
//                         return Column(
//                           children: data.asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final gambar = entry.value;
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: index != data.length - 1
//                                     ? AppSpacing.spacingM
//                                     : 0,
//                               ),
//                               child: DiagnosisItem(
//                                 imagePath: gambar.gambarUrl,
//                                 plantName: 'Unknown Plant',
//                                 diseaseName: gambar.description,
//                               ),
//                             );
//                           }).toList(),
//                         );
//                       } else if (state is GambarMLError) {
//                         return Center(
//                           child: Text(
//                             'Error: ${state.error}',
//                             style: const TextStyle(color: Colors.red),
//                           ),
//                         );
//                       }
//                       return const Center(
//                         child: Text('Start fetching your history'),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
