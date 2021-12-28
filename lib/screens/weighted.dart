import 'package:flutter/material.dart';
import 'package:average_point_counter/components/tab_bar.dart';
import 'package:average_point_counter/types.dart';

class WeightedAveragePage extends StatefulWidget {
  const WeightedAveragePage({Key? key}) : super(key: key);

  @override
  _WeightedAveragePageState createState() => _WeightedAveragePageState();
}

class _WeightedAveragePageState extends State<WeightedAveragePage> {
  final Color mainColor = const Color.fromRGBO(213, 39, 40, 1);
  final Color secondaryColor = const Color.fromRGBO(52, 62, 68, 1);

  List<WeightedMark> marks = [];
  String markInput = '';
  String coeffInput = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Расчёт по средневзвеш. баллу'),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: AppTabBar(context, 1, '/mean_average'),
      bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ваш средний балл: ', style: TextStyle(fontSize: 18)),
            Text(
                getAveragePoint(),
                style: TextStyle(
                  fontSize: 18,
                  color: getMarkColor(double.parse(getAveragePoint())),
                  fontWeight: FontWeight.bold,
                )
            ),
            const SizedBox(height: 50),
          ]
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: secondaryColor,
                          hoverColor: secondaryColor,
                          hintText: 'Оценка',
                        ),
                        onChanged: (value) {
                          setState(() {
                            markInput = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: secondaryColor,
                          hoverColor: secondaryColor,
                          hintText: 'Коэфф.',
                        ),
                        onChanged: (value) {
                          setState(() {
                            coeffInput = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(213, 39, 40, .8)),
                      ),
                      onPressed: () {
                        var c = 1.0;

                        try {
                          c = double.parse(coeffInput);
                        } catch (e) {}

                        try {
                          addPoint(
                            int.parse(markInput),
                            c
                          );
                        } catch (e) {}
                      },
                      child: const Text('Добавить'),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: marks.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return Dismissible(
                        key: Key(marks[index].createdAt.toString()),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              '${marks[index].mark}×${marks[index].coeff}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: getMarkColor(marks[index].mark.toDouble()),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            trailing: const Icon(Icons.delete_sweep),
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            marks.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  addPoint(int mark, double coeff) {
    setState(() {
      marks.add(WeightedMark(
        mark,
        coeff,
      ));
    });
  }

  String getAveragePoint() {
    double markSum = 0;
    double coeffSum = 0;

    if (marks.isEmpty) {
      return '0';
    }

    for (int i=0; i < marks.length; i++) {
      markSum += marks[i].mark * marks[i].coeff;
      coeffSum += marks[i].coeff;
    }

    return (markSum / coeffSum).toStringAsFixed(2);
  }

  Color getMarkColor(double mark) {
    if (mark == 0) {
      return Colors.black;
    }
    if (mark >= 4.5) {
      return Colors.green;
    } if (mark >= 3.5) {
      return Colors.lightGreen;
    } if (mark >= 2.5) {
      return Colors.amber;
    } if (mark >= 0) {
      return Colors.red;
    }
    return Colors.black;
  }
}
