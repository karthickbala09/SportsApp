import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Data class for charts
class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}

class AthletePerformanceScreen extends StatefulWidget {
  AthletePerformanceScreen({super.key});

  @override
  State<AthletePerformanceScreen> createState() => _AthletePerformanceScreenState();
}

class _AthletePerformanceScreenState extends State<AthletePerformanceScreen> {
  // Sample dynamic data for chart
  final List<ChartData> needsData = [
    ChartData('Strength', 100),
    ChartData('Speed', 70),
    ChartData('Endurance', 60),
    ChartData('Flexibility', 50),
    ChartData('Agility', 65),
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Athlete Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF39D2C0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top BMI Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              color: const Color(0xFF1E8F5E),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                child: Column(
                  children: [
                    Text('BMI', style: TextStyle(fontSize: 18.sp, color: Colors.white70)),
                    SizedBox(height: 8.h),
                    Text('23.4', // Sample value
                        style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8.h),
                    Text('Healthy', style: TextStyle(fontSize: 16.sp, color: Colors.white70)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Bottom Chart Card
            Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Athlete Needs',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 250.h,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0), // Remove vertical grid
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0), // Remove horizontal grid
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: needsData,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          borderRadius: BorderRadius.circular(8.r),
                          color: const Color(0xFF39D2C0),
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                        ),
                      ],

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
