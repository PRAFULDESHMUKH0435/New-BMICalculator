import 'package:bmicalculator/Hive/UserData.dart';
import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../Constants/styles.dart';
class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Hive.openBox("BMIHistory");
  final provider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "BMI History",
          style: AppStyles.titlestyle,
        ),
      ),
      body: provider.bmihistoryitems.length==0
          ?
      Center(
        child: Container(
          margin: EdgeInsets.all(15.0),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text("Oops You Have Not Checked Your BMI Yet",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red),))
            ],
          ),
        ),
      )
      :
      ListView.builder(
          itemCount:provider.bmihistoryitems.length,
          itemBuilder: (context,index){
            return Card(
              color: Color(0xFF0540CA),
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.fitness_center,color: Colors.white,),
                title: Text(provider.bmihistoryitems[index].date.toString(),style: AppStyles.historydatestyle,),
                subtitle: Text("BMI : ${provider.bmihistoryitems[index].bmi.toString()}",style: AppStyles.historybmistyle),
              ),
            );
          }),
    );
  }
}
