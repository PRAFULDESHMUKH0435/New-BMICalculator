import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bmicalculator/Constants/CustomRangeSlider.dart';
import 'package:bmicalculator/Constants/MaleAndFemaleRow.dart';
import 'package:bmicalculator/Constants/WeightAnddAgeContainer.dart';
import 'package:bmicalculator/Model/UserDataModel.dart';
import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:bmicalculator/Constants/styles.dart';
import 'package:bmicalculator/Screens/AboutUsScreen.dart';
import 'package:bmicalculator/Screens/DietPlansScreen.dart';
import 'package:bmicalculator/Screens/UserHistoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    loadInterstitialAd();
    super.initState();
  }


void loadInterstitialAd(){
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6177165685902348/4534884298', // Test ad unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          print('Ad Loaded');
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Ad Failed to Load: $error');
          _isAdLoaded = false;
        },
      ),
    );
  }

void _moveToNextScreen(BuildContext context,UserDataModel model) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>Dietplansscreen(
          age: model.age,
          BMI: model.BMI,
          height: model.height,
          result: model.result,
          weight: model.weight,
        )),
      );
  }

  void showInterstitialAd(UserDataModel usermodel) {
    print("Inside ShowAds and AdLoaded ? ${_interstitialAd?.responseInfo.toString()}");
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print("Showing Ad");
          print('Ad Dismissed');
          loadInterstitialAd();
          // ad.dispose(); // Dispose of the ad after showing
          _moveToNextScreen(context,usermodel);
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('Ad Failed to Show: $error');
          ad.dispose();
          loadInterstitialAd(); // Load another ad in case of error
          _moveToNextScreen(context,usermodel);
        },
      );
      _interstitialAd!.show();
    } else {
      print('Ad Not Ready');
      // You can choose to navigate to the next screen here if needed
      _moveToNextScreen(context,usermodel);
    }
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: const Color(0xFF181822),
        /// APPBAR
        appBar: AppBar(
          backgroundColor: const Color(0xFF21232F),
          // backgroundColor: Color(0xFF0540CA),
          centerTitle: true,
          title: const Text(
            "BMI Calculator",
            style: AppStyles.titlestyle,
          ),
        ),

        ///BODY
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFF181822)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// MALE AND FEMALE ROW
                const MaleAndFemaleRow(),

                ///Height
                const Text(
                  "Height",
                  style: AppStyles.titlestyle,
                ),

                ///Height Row
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF717880)),
                    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                    color: const Color(0xFF2D2D37),
                  ),
                  margin: const EdgeInsets.all(12.0),
                  height: 120,
                  child: const CustomRangeSlider(),
                ),

                ///Weight and Age Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Weight",
                      style: AppStyles.titlestyle,
                    ),
                    Text(
                      "Age",
                      style: AppStyles.titlestyle,
                    ),
                  ],
                ),

                ///Weight And Age Container
                const WeightAndAgeContainer(),
              ],
            ),
          ),
        ),

        /// BOTTOM NAVIGATION BAR
        bottomNavigationBar: AnimatedNotchBottomBar(
          durationInMilliSeconds: 500,
          elevation: 2.0,
          notchColor: const Color(0xFF99D9D9),
          color: const Color(0xFF0540CA),
            kBottomRadius: 20,
            kIconSize: 30,
            onTap: (newidx) {
              provider.currentscreenidx=newidx;
               if(provider.currentscreenidx==0){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUsScreen()));
               }
               else if(provider.currentscreenidx==1){
                 /// Show Model Bottom Sheet
                 provider.CalculateUserBMI(context);
                 showModalBottomSheet(context: context, builder: (context){
                  //  return const CustomBottomSheet();
                   return  showBottomSheetForDialog();
                 });
               }else{
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserHistoryScreen()));
               }
            },
            notchBottomBarController: NotchBottomBarController(
                index: provider.currentscreenidx
            ),
            bottomBarItems:const [
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                activeItem: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
              BottomBarItem(
                inActiveItem: CircleAvatar(
                  backgroundColor: Color(0xFF99D9D9),
                  radius: 30,
                  child: Text("BMI ",),
                ),
                activeItem: CircleAvatar(
                  backgroundColor: Color(0xFF99D9D9),
                  radius: 30,
                  child: Text("BMI "),
                ),
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                activeItem: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              )
            ]),
      ),
    );
  }


  Future<bool> _onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF21212B),
        title: const Text('Exit',style: TextStyle(color: Colors.white70),),
        content: const Text('Do you want to exit the app?',style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }



showBottomSheetForDialog(){
  final provider = Provider.of<HomeScreenProvider>(context);
  return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.deepPurpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView( // Added SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust to min to avoid overflow
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your BMI is',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${provider.BMI}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Kg/m²',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              provider.bmicategory,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Height : ${provider.selectedHeight.toStringAsFixed(2)} Ft | Weight : ${provider.selectedWeight} kilograms',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'A BMI of ${provider.BMI.toInt()} is in the ${provider.bmicategory} category for your height. '
                  '${provider.BMISuggestions}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: (){

                  UserDataModel usermodel = UserDataModel(
                      BMI: provider.BMI.toInt().toString(),
                      height: provider.selectedHeight.toDouble().toStringAsFixed(2),
                      weight: provider.selectedWeight.toDouble().toString(),
                      age: provider.selectedAge.toDouble().toString(),
                      result: provider.bmicategory);

                  showInterstitialAd(usermodel);
                },
                child: const Text("Check Out Diet Plans ->",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
}
}
