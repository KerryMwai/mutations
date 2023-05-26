import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mutation/core/data/repository/user_repository.dart';
import 'package:mutation/core/model/user.dart';
import 'package:mutation/core/presentation/screens/all_users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  String? _userId;
  String usname = '';
  String uname = '';
  String uemail='';
  String uphone = '';
  Map<String, dynamic>? _user;
  @override
  void initState() {
    // TODO: implement initState
   
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userId = ModalRoute.of(context)?.settings.arguments as String?;

      if (_userId == null) {
        loadData(_userId ?? '');
      }

      name.addListener(() {
        name.text.trim();
      });

      username.addListener(() {
        username.text.trim();
      });

      email.addListener(() {
        email.text.trim();
      });
    });

    phone.addListener(() {
      phone.text.trim();
    });

     super.initState();
  }

  loadData(String id)async{
      // _user=await getUser(id:int.tryParse(id));

      if(_user!=null && _user!.isNotEmpty){
          name.text=_user!['name'] ??'';
          username.text=_user!['username']?? '';
          email.text=_user!['email'] ?? '';
          phone.text=_user!['phone']??'';
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Allusers()));
          }, icon:const  Icon(Icons.people))
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter user name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter phone number',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: ()async {
                await UserInteraction().createAUser(User(name: name.text, username: username.text, email: email.text, phone: phone.text));
              }, child: const Text("Add User"))
            ],
          )
        ],
      )),
      // floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
    );
  }


   bool allowToSubmit() {
    return uname.isNotEmpty && uemail.isNotEmpty && usname.isNotEmpty && uphone.isNotEmpty;
  }
}
