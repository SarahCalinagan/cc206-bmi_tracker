import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/components/home_drawer.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class ProgressPage extends StatefulWidget {
  final int userId;

  ProgressPage({required this.userId});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<Map<String, dynamic>> bmiResults = [];
  double currentBMI = 0.0;
  double lastBMI = 0.0;
  String lastBMIDate = '';

  @override
  void initState() {
    super.initState();
    loadBMIResults();
  }

  void loadBMIResults() async {
    bmiResults = await DatabaseHelper.instance.queryBMIResults(widget.userId);

    setState(() {});
  }

  String calculateNextBMIReviewDate(List<Map<String, dynamic>> bmiResults) {
    if (bmiResults.isNotEmpty) {
      // Find the latest date in the records
      DateTime latestDate =
          DateTime.parse(bmiResults.first[DatabaseHelper.bmiColumnDate]);

      // Calculate the next review date by adding 21 days
      DateTime nextReviewDate = latestDate.add(Duration(days: 21));

      // Format the date as a string
      return DateFormat('MM-dd-yyyy').format(nextReviewDate);
    } else {
      // If there are no records, display a default message
      return 'No records found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VitalityQuest',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 16, 15, 94),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: HomeDrawer(userId: widget.userId),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 15, 94), // RGB values for dark blue
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              'PROGRESS',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 35, 122),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'BMI Chart',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // Adjusted the height of the line chart to fit within the container
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future:
                          DatabaseHelper.instance.getBMIResults(widget.userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<Map<String, dynamic>> bmiResults =
                              snapshot.data!;
                          List<double> bmiValues = bmiResults
                              .map((result) => result['bmi_result'] as double)
                              .toList();
                          List<String> dates = bmiResults
                              .map((result) => result['date'] as String)
                              .toList();

                          List<charts.Series<BmiData, DateTime>> seriesList = [
                            charts.Series<BmiData, DateTime>(
                              id: ' ',
                              colorFn: (_, __) => charts
                                  .MaterialPalette.deepOrange.shadeDefault,
                              domainFn: (BmiData data, _) => data.date,
                              measureFn: (BmiData data, _) => data.bmi,
                              data: List.generate(
                                bmiValues.length,
                                (index) => BmiData(
                                  DateTime.parse(dates[index]),
                                  bmiValues[index],
                                ),
                              ),
                            ),
                          ];

                          return LongPressGestureRecognizerWidget(
                            child: charts.TimeSeriesChart(
                              seriesList,
                              animate: true,
                              behaviors: [
                                charts.SeriesLegend(),
                              ],
                              defaultRenderer: charts.LineRendererConfig(
                                includePoints: true,
                              ),
                              domainAxis: charts.DateTimeAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.white,
                                  ),
                                ),
                              ),
                              primaryMeasureAxis: charts.NumericAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.white,
                                  ),
                                ),
                                viewport: charts.NumericExtents(
                                    10.0, 40.0), // Set the starting point
                              ),
                            ),
                            bmiDataList: List.generate(
                              bmiValues.length,
                              (index) => BmiData(
                                DateTime.parse(dates[index]),
                                bmiValues[index],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 35, 122),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BMI Progress',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your BMI: ${bmiResults.isNotEmpty ? bmiResults.first[DatabaseHelper.bmiColumnBmiResult]?.toStringAsFixed(2) : '-'}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Your Last BMI: ${bmiResults.length > 1 ? bmiResults[1][DatabaseHelper.bmiColumnBmiResult]?.toStringAsFixed(2) : '-'}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'BMI Difference: ${bmiResults.length > 1 ? (bmiResults.first[DatabaseHelper.bmiColumnBmiResult] - bmiResults[1][DatabaseHelper.bmiColumnBmiResult]).toStringAsFixed(2) : '-'}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Next BMI Checking: ${calculateNextBMIReviewDate(bmiResults)}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ... Rest of the code

class LongPressGestureRecognizerWidget extends HookWidget {
  final Widget child;
  final List<BmiData> bmiDataList;

  LongPressGestureRecognizerWidget(
      {required this.child, required this.bmiDataList});

  @override
  Widget build(BuildContext context) {
    final tooltipVisible = useState(false);
    final tooltipPosition = useState(Offset.zero);
    final tooltipText = useState('');

    void showTooltip(Offset position, BmiData data) {
      tooltipPosition.value = position;
      tooltipText.value =
          'BMI: ${data.bmi.toStringAsFixed(2)}\nDate: ${DateFormat('MM-dd-yyyy').format(data.date.toLocal())}';
      tooltipVisible.value = true;
    }

    return GestureDetector(
      onLongPressMoveUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        var localPosition = renderBox.globalToLocal(details.globalPosition);

        // Calculate the index of the selected point in the line chart
        final chartWidth = renderBox.size.width;
        final index = ((localPosition.dx / chartWidth) * bmiDataList.length)
            .clamp(0, bmiDataList.length - 1)
            .toInt();

        // Retrieve the actual BMI and date values corresponding to the selected point
        final selectedBmiData = bmiDataList[index];

        showTooltip(localPosition, selectedBmiData);
      },
      onLongPressEnd: (details) {
        tooltipVisible.value = false;
      },
      child: Stack(
        children: [
          child,
          if (tooltipVisible.value)
            Positioned(
              left: tooltipPosition.value.dx - 50,
              top: tooltipPosition.value.dy - 90,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  tooltipText.value,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class BmiData {
  final DateTime date;
  final double bmi;

  BmiData(this.date, this.bmi);
}
