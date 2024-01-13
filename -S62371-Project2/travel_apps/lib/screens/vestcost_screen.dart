import 'package:flutter/material.dart';
import '../models/activityPrice_model.dart';
import '../widgets/drawer.dart';

class ViewEstimateCost extends StatefulWidget {
  final String username;

  const ViewEstimateCost({super.key, required this.username});
  @override
  _ViewEstimateCostState createState() => _ViewEstimateCostState();
}

class _ViewEstimateCostState extends State<ViewEstimateCost>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCountry = 'Malaysia';
  List<Activity> selectedActivities = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);

    // Listen for tab changes
    _tabController.addListener(() {
      // Clear selected activities when the tab changes
      setState(() {
        selectedActivities.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: Text('View Estimate Cost'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Malaysia'),
            Tab(text: 'China'),
            Tab(text: 'India'),
            Tab(text: 'Thailand'),
            Tab(text: 'Korea'),
            Tab(text: 'Japan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabView('Malaysia'),
          _buildTabView('China'),
          _buildTabView('India'),
          _buildTabView('Thailand'),
          _buildTabView('Korea'),
          _buildTabView('Japan'),
        ],
      ),
      drawer: CustomDrawer(username: widget.username),
    );
  }

  Widget _buildTabView(String country) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: ActivityPriceModel.activities[country]!
                .map((activity) => _buildActivityTile(activity, country))
                .toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF3B5998),
          child: Text(
            'Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTile(Activity activity, String country) {
    return ListTile(
      title: Text(activity.name),
      subtitle: Text('\$${activity.price.toStringAsFixed(2)}'),
      trailing: Checkbox(
        value: selectedActivities.contains(activity),
        onChanged: (value) {
          setState(() {
            if (value!) {
              selectedActivities.add(activity);
            } else {
              selectedActivities.remove(activity);
            }
          });
        },
      ),
    );
  }

  double _calculateTotalPrice() {
    double totalPrice = 0;
    for (Activity activity in selectedActivities) {
      totalPrice += activity.price;
    }
    return totalPrice;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
