import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import '../Cubit/Activity cubit/chartcubit.dart';
import '../Cubit/Activity cubit/chartstate.dart';
import '../Custom_widget/chartwidget/buildgrafic.dart';
import '../Model/models/activitymodel.dart';

class chart extends StatelessWidget {
  const chart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chartcubit(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Daily Activity'),
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              const pinkled(200, 100),
              const pinkled(700, 100),
              const BlueLed(30, 250),
              const BlueLed(430, 350),
              BlocBuilder<chartcubit, chartstate>(
                builder: (context, state) {

                  if (state is succeschart) {
                    activitymodel? chart =
                        BlocProvider.of<chartcubit>(context).chart;
                    int total = (chart!.homework_percentage +
                        chart.exam_percentage +
                        chart.oral_exam_percentage +
                        chart.task_percentage.toDouble() +
                        chart.quiz_percentage)
                        .toInt();
                    final List<PieData> pies = [
                      PieData(
                        value: chart.homework_percentage.toDouble(),
                        color: Colors.purple,
                      ),
                      PieData(
                          value: chart.exam_percentage.toDouble(),
                          color: Colors.pink),
                      PieData(
                          value: chart.oral_exam_percentage.toDouble(),
                          color: Colors.cyanAccent),
                      PieData(
                          value: chart.task_percentage.toDouble(),
                          color: Colors.red),
                      PieData(
                          value: chart.quiz_percentage.toDouble(),
                          color: Colors.orange),
                      PieData(
                          value: 100 -
                              chart.homework_percentage -
                              chart.exam_percentage -
                              chart.oral_exam_percentage -
                              chart.task_percentage.toDouble() -
                              chart.quiz_percentage,
                          color: Colors.grey.withOpacity(.4)),
                    ];
                    List<VBarChartModel> bardata = [
                      VBarChartModel(
                        index: 0,
                        label: "Exam",
                        colors: [Colors.pinkAccent, Colors.pink],
                        jumlah: chart.exam.toDouble(),
                        tooltip: '${chart.exam} / ${chart.total_exam}',
                      ),
                      VBarChartModel(
                        index: 1,
                        label: "Quiz",
                        colors: [Colors.orange, Colors.deepOrange],
                        jumlah: chart.quiz.toDouble(),
                        tooltip: '${chart.quiz} / ${chart.total_quiz}',
                      ),
                      VBarChartModel(
                        index: 2,
                        label: "Task",
                        colors: [Colors.red, Colors.redAccent],
                        jumlah: chart.task.toDouble(),
                        tooltip: '${chart.task} / ${chart.total_task}',
                      ),
                      VBarChartModel(
                          index: 3,
                          label: "H.W",
                          colors: [Colors.purple, Colors.purpleAccent],
                          jumlah: chart.homework.toDouble(),
                          tooltip: '${chart.homework} / ${chart.total_homework}'),
                      VBarChartModel(
                        index: 4,
                        label: "Oral",
                        colors: [Colors.cyan, Colors.cyanAccent],
                        jumlah: chart.oral_exam.toDouble(),
                        tooltip: '${chart.oral_exam} / ${chart.total_oral_exam}',
                      ),
                    ];
                    return Column(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        EasyPieChart(
                          animateDuration: const Duration(seconds: 5),
                          centerStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiaryFixed,
                              fontSize: 30),
                          centerText: 'Overall\n $total%  ',
                          showValue: total == 0 ? false : true,
                          borderWidth: 45.w,
                          key: const Key('pie 2'),
                          children: pies,
                          pieType: PieType.crust,
                          gap: .1,
                          start: 0,
                          animateFromEnd: true,
                          size: 230.h,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        buildgrafic(bardata: bardata, legend: [
                          Vlegend(
                            textColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            size: 15.h,
                            isSquare: false,
                            color: Colors.pinkAccent,
                            text: "EXAM",
                          ),
                          Vlegend(
                            textColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            size: 15.h,
                            isSquare: false,
                            color: Colors.orange,
                            text: "QUIZ",
                          ),
                          Vlegend(
                            textColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            size: 15.h,
                            isSquare: false,
                            color: Colors.cyanAccent,
                            text: "ORAL",
                          ),
                          Vlegend(
                            textColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            size: 15.h,
                            isSquare: false,
                            color: Colors.purple,
                            text: "H.W",
                          ),
                          Vlegend(
                            textColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            size: 15.h,
                            isSquare: false,
                            color: Colors.red,
                            text: "TASKS",
                          )
                        ]),
                        const Spacer()
                      ],
                    );
                  } else if (state is loadingchart) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.pink,
                    ));
                  } else {
                    return const Center(child: Text('initial'));
                  }
                },
              ),
            ],
          )),
    );
  }
}
