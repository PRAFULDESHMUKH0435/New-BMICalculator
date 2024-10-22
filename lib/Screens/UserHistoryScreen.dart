import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:flutter/material.dart';
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
   final provider = Provider.of<HomeScreenProvider>(context);
   print("Lenght ${provider.bmihistoryitems.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "BMI History",
          style: AppStyles.titlestyle,
        ),
      ),
      body: provider.bmihistoryitems.isEmpty
          ?
      Center(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey
          ),
          child: const Column(
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
              color: const Color(0xFF0540CA),
              elevation: 4.0,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.fitness_center,color: Colors.white,),
                title: Text(provider.bmihistoryitems[index].date.toString(),style: AppStyles.historydatestyle,),
                subtitle: Text("BMI : ${provider.bmihistoryitems[index].bmi.toString()}",style: AppStyles.historybmistyle),
              ),
            );
          }),
    );
  }
}
