import 'package:bmicalculator/Constants/CustomLoadingIcon.dart';
import 'package:bmicalculator/Services/DataService.dart';
import 'package:flutter/material.dart';
import '../Constants/styles.dart';

class Dietplansscreen extends StatefulWidget {
  String BMI;
  String height;
  String weight;
  String age;
  String result;
  Dietplansscreen({super.key, 
    required this.BMI,
    required this.height,
    required this.weight,
    required this.age,
    required this.result,
  });

  @override
  State<Dietplansscreen> createState() => _DietplansscreenState();
}

class _DietplansscreenState extends State<Dietplansscreen> {
  NetworkService service = NetworkService();

  final List<Map<String, String>> _messages = []; // To store messages from bot and user
  final TextEditingController _controller = TextEditingController();
  bool _showTextField = false; // Controls the visibility of the TextField
  String _userName = ""; // Store user input name
  bool _askedDietPreference = false; // Whether diet preference has been asked

  String _dietType ="vegetarian";
  String get dietType => _dietType;
  set dietType(String value) {
    _dietType = value;
  }
  late AnimationController _animationcontroller;

  @override
  void initState() {
    super.initState();
    _startBotConversation();
  }

  // Function to start the bot conversation
  void _startBotConversation() async{
    String message;
    if (service.isusernamepresent) {
      // If username exists in the service
      _userName =service.username;
      message = "Hi $_userName, Welcome Back";
      _askDietPreference();
    } else {
      // If username does not exist in the service
      message = "Hello! Please enter your name.";
    }
    _botSendMessage(message);
  }

  // Function to send bot messages
  void _botSendMessage(String message) {
    setState(() {
      _messages.add({"sender": "bot", "message": message});
      _showTextField = true; // Show TextField when the bot asks for the name or preference
    });
  }

  // Function to handle user input and send messages
  void _handleUserInput() {
    String input = _controller.text.trim();
    if (input.isEmpty) return;

    setState((){
      _messages.add({"sender": "user", "message": input});
      _controller.clear(); // Clear the TextField after input

      if (_userName.isEmpty) {
        // Case 1: User entered their name for the first time
        _userName = input;
        service.SaveUserName(_userName);
        service.isusernamepresent=true;
        _botSendMessage("Hi $_userName! My name is Vaayu, your Diet Planner Assistant.");
        _askDietPreference();
      // } else if (_askedDietPreference == true) {
      //   // Case 2: User is selecting diet preference
      //   if (input.toLowerCase() == "vegetarian" || input.toLowerCase() == "veg") {
      //     _botSendMessage("Great! You chose Vegetarian.");
      //     dietType="vegetarian";
      //     _askedDietPreference = true; // Update this flag to true to avoid looping
      //     // _displayUserData();
      //     _fetchDietPlan();
      //   } else if (input.toLowerCase() == "non-vegetarian" || input.toLowerCase() == "nonveg") {
      //     _botSendMessage("Great! You chose Non-Vegetarian.");
      //     dietType="Non-vegetarian";
      //     _askedDietPreference = true; // Update this flag to true to avoid looping
      //     // _displayUserData();
      //     _fetchDietPlan();
      //   } else {
      //     // Invalid input, ask again
      //     _botSendMessage("Please select 'Vegetarian' or 'Non-Vegetarian'.");
      //   }
      }
    });
  }



  // Function to ask for diet preference
  void _askDietPreference() async{
    _botSendMessage("Based On Your BMI Result Below Is Diet Plan For You ..\n Here is the data we have:\nAge: ${widget.age}\nBMI: ${widget.BMI}\nHeight: ${widget.height}\nWeight: ${widget.weight}\n Category : ${widget.result}\n\n"
        "And Based On This Data We Are Calculating Diet For You");
    _askedDietPreference = true;
    _fetchDietPlan();
    // _displayUserData();
  }

  // Function to display user's data (BMI, height, weight, age)
  // void _displayUserData() {
  //   _botSendMessage(
  //       "Test");
  //   _fetchDietPlan();
  // }

  // Function to make an API call for the diet plan based on user data
  void _fetchDietPlan() async {
    await Future.delayed(const Duration(seconds: 2));

    showDialog(context: context, builder: (context){
      return const Center(child: CustomLoadingIcon());
    });
    String FinalDiet ="";
    if(widget.result=="Underweight"){
      FinalDiet ="This Diet plan may include whole wheat poha, boiled sprouts, nuts, an apple, vegetable soup, brown rice, dal, a dry vegetable, 1-2 fruits, roasted chana, vegetable upma, 1 egg omelette, and a small plate of salad.";
    }else if(widget.result=="OverWeight"){
      FinalDiet="A healthy eating plan may include vegetables, fruits, whole grains, and fat-free or low-fat dairy products. It may also include lean meats, poultry, fish, beans, eggs, and nuts";
    }else if(widget.result=="Normal"){
      FinalDiet="A healthy diet plan may include swapping unhealthy and high-energy food choices for healthier choices. It may also include plenty of fruit and vegetables, and meals based on potatoes, bread, rice, pasta, and other starchy foods.";
    }else if(widget.result=="Obese"){
      FinalDiet="A healthy diet plan may include reducing intake of less healthy fats and keeping total fat intake to less than 25% of the diet's energy. It may also include increasing the proportion of low-energy-dense foods, such as vegetables and fruits, and low-fat dairy products.";
    }else{
      FinalDiet ="Please Try Again";
    }
    _botSendMessage("Diet");
    _botSendMessage(FinalDiet);
    Navigator.pop(context);
    _showTextField = false;
  }


  @override
  Widget build(BuildContext context) {
    print(
        "Received Data: \nBMI: ${widget.BMI}\nHeight: ${widget.height}\nWeight: ${widget.weight}\nAge: ${widget.age}\nResult: ${widget.result}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome to Diet Planner",
          style: AppStyles.titlestyle,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:AssetImage("Assets/Images/diet_plan.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            // Display messages in a ListView
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ListTile(
                    title: Align(
                      alignment: message['sender'] == 'user'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message['sender'] == 'user'
                              ? Colors.blue[100]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(message['message']!),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Show TextField only when required
            if (_showTextField)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: _userName.isEmpty
                                ? 'Enter your name'
                                : 'Type your message...',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: _handleUserInput,
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
