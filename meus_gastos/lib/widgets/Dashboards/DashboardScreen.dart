import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'MonthSelector.dart';
import 'package:meus_gastos/services/CardService.dart';
import 'LinearProgressIndicatorSection.dart';
import 'DashboardCard.dart';

class DashboardScreen extends StatefulWidget {
  final bool isActive;

  DashboardScreen({this.isActive = false});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  List<ProgressIndicatorModel> progressIndicators = [];
  List<PieChartDataItem> pieChartDataItems = [];
  bool isLoading = true;
  DateTime currentDate = DateTime.now();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadProgressIndicators(DateTime.now());
  }

  void _changeMonth(int delta) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + delta);
      _loadProgressIndicators(currentDate);
    });
  }

  Future<void> _loadProgressIndicators(DateTime currentDate) async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    progressIndicators =
        await CardService.getProgressIndicatorsByMonth(currentDate);
    pieChartDataItems.clear();
    for (var progressIndicator in progressIndicators) {
      pieChartDataItems.add(progressIndicator.toPieChartDataItem());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoPageScaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      navigationBar: CupertinoNavigationBar(
        middle: Text("Meu Controle",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              MonthSelector(
                currentDate: currentDate,
                onChangeMonth: _changeMonth,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DashboardCard(
                  items: pieChartDataItems,
                ),
              ),
              if (isLoading)
                CircularProgressIndicator(color: Colors.white)
              else
                Column(
                  children: [
                    for (var progressIndicator in progressIndicators)
                      LinearProgressIndicatorSection(
                          model: progressIndicator,
                          totalAmount: progressIndicators.fold(
                              0,
                              (maxValue, item) => maxValue > item.progress
                                  ? maxValue
                                  : item.progress)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}