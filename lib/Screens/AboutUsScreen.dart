import 'package:bmicalculator/Constants/styles.dart';
import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "About Us",
          style: AppStyles.titlestyle,
        ),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ExpansionTile(
              onExpansionChanged: (bool isexpanded){
                provider.isexpandedwhoweare=!provider.isexpandedwhoweare;
              },
              title:const Text("Who We Are?",style:AppStyles.aboutusquestionstyle),
              trailing:provider.isexpandedwhoweare?const Icon(Icons.remove): const Icon(Icons.add),children: const [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal:14.0),
                  child: Text(AppStyles.AboutText))
            ],),
            ExpansionTile(
              onExpansionChanged: (bool isexpanded){
                provider.isexpandedaboutapp=!provider.isexpandedaboutapp;
              },
              title:const Text("About App ",style:AppStyles.aboutusquestionstyle,),
              trailing: provider.isexpandedaboutapp?const Icon(Icons.remove): const Icon(Icons.add),children: const [
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
