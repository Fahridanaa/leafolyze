import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/article/article_bloc.dart';
import 'package:leafolyze/blocs/article/article_event.dart';
import 'package:leafolyze/blocs/article/article_state.dart';
import 'package:leafolyze/blocs/history/history_bloc.dart';
import 'package:leafolyze/blocs/history/history_event.dart';
import 'package:leafolyze/blocs/history/history_state.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
import 'package:leafolyze/repositories/article_repository.dart';
import 'package:leafolyze/repositories/detection_repository.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';
import 'package:leafolyze/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(
            ArticleRepository(
              context.read<ApiService>(),
              context.read<StorageService>(),
            ),
          )..add(LoadArticles()),
        ),
        BlocProvider(
            create: (context) => HistoryBloc(
                  DetectionRepository(
                    context.read<ApiService>(),
                    context.read<StorageService>(),
                  ),
                )..add(LoadDetections())),
      ],
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            shrinkWrap: true,
            scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false,
            ),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildGreetingSection(),
                    SizedBox(height: AppSpacing.spacingL),
                    _buildWateringReminder(),
                    SizedBox(height: AppSpacing.spacingM),
                    _buildArticleSection(
                      onPressed: () {
                        context.push('/home/article');
                      },
                    ),
                    SizedBox(height: AppSpacing.spacingL),
                    _buildRecentDiagnosis(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildGreetingSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, John',
            style: TextStyle(
              fontSize: AppFontSize.fontSizeMS,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          Text(
            'Good Morning!',
            style: TextStyle(
              fontSize: AppFontSize.fontSizeM,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ],
      ),
      CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            'https://awsimages.detik.net.id/community/media/visual/2018/03/03/39f24229-6f26-4a17-aa92-44c3bd3dae9e_43.jpeg?w=600&q=90'),
      ),
    ],
  );
}

Widget _buildWateringReminder() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.all(AppSpacing.spacingL),
        decoration: BoxDecoration(
          color: AppColors.primaryColorLight,
          borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 9),
              blurRadius: 15.3,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watering Reminder!',
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeM,
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.primaryColorDark,
                    ),
                  ),
                  SizedBox(height: AppSpacing.spacingXXS),
                  Text(
                    'Give enough water to maximize plant growth',
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeS,
                      fontWeight: AppFontWeight.medium,
                      color: AppColors.actionTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        right: 0,
        bottom: -12,
        child: Image.asset(
          'assets/images/image-13.png',
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

Widget _buildArticleSection({required Function() onPressed}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore Article',
            style: TextStyle(
              fontSize: AppFontSize.fontSizeMS,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See all',
              style: TextStyle(
                fontSize: AppFontSize.fontSizeMS,
                fontWeight: AppFontWeight.semiBold,
                color: AppColors.actionTextColor,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 120,
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ArticleError) {
              return Center(child: Text(state.message));
            }

            if (state is ArticleLoaded) {
              final articles =
                  state.articles.take(5).toList(); // Only take first 5 articles

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/home/article/${article.id}');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 240,
                          margin: EdgeInsets.only(right: AppSpacing.spacingS),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppBorderRadius.radiusS),
                            image: DecorationImage(
                              image: article.image?.path != null
                                  ? NetworkImage(article.image!.path)
                                  : const AssetImage(
                                          'assets/images/articledetail.jpg')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 240,
                          margin: EdgeInsets.only(right: AppSpacing.spacingS),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppBorderRadius.radiusS),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.7],
                            ),
                          ),
                          padding: EdgeInsets.all(AppSpacing.spacingS),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppFontSize.fontSizeS,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                              SizedBox(height: AppSpacing.spacingXXS),
                              SizedBox(
                                width: 160,
                                child: Text(
                                  article.content,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: AppFontSize.fontSizeXXS,
                                    fontWeight: AppFontWeight.regular,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('No articles found'));
          },
        ),
      ),
    ],
  );
}

Widget _buildRecentDiagnosis() {
  return BlocBuilder<HistoryBloc, HistoryState>(
    builder: (context, state) {
      return Container(
        constraints: const BoxConstraints(
          minHeight: 350,
        ),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.spacingS,
          0,
          AppSpacing.spacingS,
          AppSpacing.spacingMS,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 15,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Add this
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingXS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Recent Diagnosis',
                      style: TextStyle(
                        fontSize: AppFontSize.fontSizeMS,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/history');
                    },
                    child: Center(
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeMS,
                          fontWeight: AppFontWeight.semiBold,
                          color: AppColors.actionTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildContent(state),
          ],
        ),
      );
    },
  );
}

Widget _buildContent(HistoryState state) {
  if (state is HistoryLoading) {
    return const SizedBox(
      height: 200, // Match container's minHeight
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  } else if (state is HistoryLoaded) {
    if (state.detections.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.spacingM),
        child: Text('No recent diagnoses'),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.detections.take(3).length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.spacingS),
      itemBuilder: (context, index) {
        final detection = state.detections[index];
        return DiagnosisItem(
          imagePath: detection.image?.path ?? '',
          plantName: detection.title,
          diseaseName: detection.diseases?[0].name ?? '',
          onTap: () {
            context.push('/history/detection/${detection.id}');
          },
        );
      },
    );
  } else if (state is HistoryError) {
    return Center(
      child: Text(
        'Error: ${state.error}',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
  return const Center(
    child: Text('Start scanning leaves to see your diagnoses'),
  );
}
