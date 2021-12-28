import 'package:flutter/material.dart';
import 'package:average_point_counter/components/tab_bar.dart';
import 'package:average_point_counter/types.dart';

class MeanPointPage extends StatefulWidget {
  const MeanPointPage({Key? key}) : super(key: key);

  @override
  _MeanPointPageState createState() => _MeanPointPageState();
}

class _MeanPointPageState extends State<MeanPointPage> {
  final Color mainColor = const Color.fromRGBO(213, 39, 40, 1);
  final Color secondaryColor = const Color.fromRGBO(52, 62, 68, 1);

  List<MeanMark> marks = [];
  String inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расчёт по ср.арифм.'),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: AppTabBar(context, 0, '/weighted_average'),
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
                          inputValue = value;
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
                      try {
                        addPoint(int.parse(inputValue));
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
                            marks[index].mark.toString(),
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

  String getAveragePoint() {
    if (marks.isEmpty) {
      return '0';
    }

    int sum = 0;

    for (int i=0; i < marks.length; i++) {
      sum += marks[i].mark;
    }

    return (sum / marks.length).toStringAsFixed(2);
  }

  Color getMarkColor(double mark) {
    if (mark == 0) {
      return Colors.black;
    }
    if (mark >= 4.5) {
      return Colors.green;
    } if (mark >= 3.5) {
      return Colors.blue;
    } if (mark >= 2.5) {
      return Colors.amber;
    } if (mark >= 0) {
      return Colors.red;
    }
    return Colors.black;
  }

  addPoint(int newPoint) {
    setState(() {
      marks.add(MeanMark(newPoint));
    });
  }
}
