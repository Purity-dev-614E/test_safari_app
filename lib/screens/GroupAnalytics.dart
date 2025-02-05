import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Groupanalytics extends StatefulWidget {
  const Groupanalytics({super.key});

  @override
  State<Groupanalytics> createState() => _GroupanalyticsState();
}

class _GroupanalyticsState extends State<Groupanalytics> {

  String selectedTimeFilter = "Week"; //Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Analytics"),
      ),
      body: Column(
        children: [
          //time filter dropdown
          Padding(
              padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedTimeFilter,
              onChanged: (newValue){
                setState(() {
                  selectedTimeFilter = newValue!;
                });
              },
                items: ['Week','Month','Year'].map((filter){
                  return DropdownMenuItem(
                    value: filter,
                      child: Text(filter)
                  );
                }).toList(),
              decoration: InputDecoration(
                labelText: "Select Time Filter",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
          ),
          //Pie Chart - Group Demographics
          Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: 40,
                    title: "Youth",
                    radius: 50,
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 40,
                    title: "Adults",
                    radius: 50,
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: 40,
                    title: "Elders",
                    radius: 50,
                  ),
                ]
              )
            ),
          )
          ),
          //BAR CHARTS -EVENT ATTENDANCE
          Expanded(
              child: Padding(padding: const EdgeInsets.all(8.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: [
                      BarChartGroupData(x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 80,
                          color: Colors.blue,
                          width: 15,
                        ),
                      ],
                      ),
                      BarChartGroupData(
                          x: 2,
                        barRods: [
                          BarChartRodData(
                              toY: 60,
                            color: Colors.green,
                            width: 15,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                          x: 3,
                        barRods: [
                          BarChartRodData(
                              toY: 90,
                            color: Colors.orange,
                            width: 15,
                          )
                        ]
                      )
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta){
                            switch (value.toInt()){
                              case 1:
                                return const Text("Service");
                              case 2:
                                return const Text ("Retreat");
                              case 3:
                                return const Text("Outreach");
                              default:
                                return const Text("");
                            }
                          }
                        )
                      )
                    )
                  )
                ),
              )
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
              label: "Group Members",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            )
          ],
              onTap: (index){
            if (index == 0){
              Navigator.pushNamed(context, "/GroupMembers");
            }
            else if (index == 1){
              Navigator.pushNamed(context, "/adminDashboard");
            }
           },
      ),
    );
  }
}
