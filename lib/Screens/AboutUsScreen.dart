import 'package:bmicalculator/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "About Us",
          style: AppStyles.titlestyle,
        ),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: const Column(
          children: [
            ExpansionTile(title:Text("Who We Are?",style:AppStyles.aboutusquestionstyle),trailing: Icon(Icons.add),children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal:14.0),
                  child: Text(AppStyles.AboutText))
            ],),
            ExpansionTile(title:Text("About App ",style:AppStyles.aboutusquestionstyle,),trailing: Icon(Icons.add),children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(AppStyles.aboutapp))
            ],),
          ],
        ),
      ),
    );
  }
}
