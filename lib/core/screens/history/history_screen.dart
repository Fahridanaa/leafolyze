import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_state.dart';
import 'package:leafolyze/blocs/history/history_bloc.dart';
import 'package:leafolyze/blocs/history/history_event.dart';
import 'package:leafolyze/blocs/history/history_state.dart';
import 'package:leafolyze/core/screens/diagnosis/result_screen.dart';
import 'package:leafolyze/core/screens/home/skeleton.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
import 'package:leafolyze/utils/constants.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetectionBloc, DetectionState>(
          listener: (context, state) {
            if (state is DetectionSuccess) {
              context.read<HistoryBloc>().add(RefreshDetections());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Riwayat Deteksi'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HistoryBloc>().add(RefreshDetections());
          },
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryInitial) {
                context.read<HistoryBloc>().add(LoadDetections());
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HistoryLoading) {
                return const HistoryShimmer();
              }

              if (state is HistoryLoaded) {
                if (state.detections.isEmpty) {
                  return const Center(
                    child: Text('Belum ada riwayat deteksi'),
                  );
                }
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(AppSpacing.spacingM),
                  child: ListView.builder(
                    itemCount: state.detections.length,
                    itemBuilder: (context, index) {
                      final detection = state.detections[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: AppSpacing.spacingM),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.radiusM),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 15,
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  detectionId: detection.id ?? 0,
                                  title: detection.title,
                                  diseaseId:
                                      detection.diseases?.firstOrNull?.id ?? 0,
                                  imageUrl: detection.image?.path ?? '',
                                  description:
                                      'Deskripsi untuk ${detection.title}',
                                  treatmentTitle: 'Pengobatan',
                                  treatments: [],
                                  pesticideTitle: 'Pestisida',
                                  pesticides: [],
                                  timestamp: DateTime.now().toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(AppSpacing.spacingM),
                            child: DiagnosisItem(
                              imagePath: detection.image?.path ?? '',
                              plantName: detection.title,
                              diseaseName:
                                  detection.diseases?.firstOrNull?.name ??
                                      'Tidak ada penyakit terdeteksi',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is HistoryError) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
