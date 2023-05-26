import 'package:flutter/material.dart';
import 'package:mutation/core/data/repository/user_repository.dart';
import 'package:provider/provider.dart';

class Allusers extends StatefulWidget {
  const Allusers({super.key});

  @override
  State<Allusers> createState() => _AllusersState();
}

class _AllusersState extends State<Allusers> {
  
  @override
  Widget build(BuildContext context) {
    UserInteraction usersNotifier=Provider.of<UserInteraction>(context);
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("All users"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40,),
          SizedBox(
            height: 300,
            child: Expanded(
                child: ListView(
                  children: List.generate(usersNotifier.allusers.length, (index) {
                  final user=usersNotifier.allusers[index];
                  return Card(
                    
                    margin:const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width*0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name, style: const TextStyle(fontSize: 18),),
                                const SizedBox(height: 5,),
                                Text(user.email,style: const TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          const SizedBox(width: 40,),
                          SizedBox(
                            width: size.width*0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.username, style: const TextStyle(fontSize: 15),),
                                const SizedBox(height: 5,),
                                Text(user.phone, style: const TextStyle(fontSize: 15),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                              }),
                            )),
          ),
          SizedBox(width: 170, child: ElevatedButton(onPressed: (){
            context.read<UserInteraction>().getAllUsers();
          }, child: const Text("Fetch Users")),)
        ],
      ),
    );
  }
}
