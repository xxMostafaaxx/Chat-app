import 'package:chat_app/components/ChatBuble.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
   ChatPage({Key? key}) : super(key: key);



   @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller=TextEditingController();
  final ScrollController _controller = ScrollController();


  @override
  Widget build(BuildContext context) {
   var email =ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt',descending: true).snapshots(),
      builder: (context,snapshot)

     {
        if(snapshot.hasData)
          {
            List<Message> messagesList=[];
            for(int i =0;i<snapshot.data!.docs.length;i++)
              {
                messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
              }
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  title:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icon/chat.png",height: 50,width: 50,
                      ),SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Chat",
                        style: GoogleFonts.gemunuLibre(
                            textStyle: const TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                      ),


                    ],
                  ),

                ),
                body:Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        reverse: true,
                        controller: _controller,
                          itemBuilder:(context,index){
                          return messagesList[index].id
                              ==email ? ChatBuble(
                              message: messagesList[index]
                          ) :ChatBubleForFriend(
                            message: messagesList[index],);
                          },
                          separatorBuilder:(context,index)=>SizedBox(height: 10,),
                          itemCount: messagesList.length
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                          controller: controller,
                          onSubmitted: (data)
                          {
                            messages.add({
                              'message':data,
                              "createdAt":DateTime.now(),
                              'id':email,
                            });
                            controller.clear();

                            _controller.animateTo(
                              0,
                             duration: Duration(seconds: 2),
                            curve: Curves.easeInOut

                            );
                          },
                          decoration: InputDecoration(
                              hintText: "Send a message",
                              suffixIcon: Icon(Icons.send),
                              enabledBorder:  OutlineInputBorder(
                                borderRadius:BorderRadius.circular(20) ,
                                borderSide:  BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ) ,
                              focusedBorder:  OutlineInputBorder(
                                borderRadius:BorderRadius.circular(20) ,
                                borderSide:  BorderSide(
                                  color: kPrimaryColor,

                                ),
                              )
                          )
                      ),
                    )
                  ],
                )

            );
          }

        else{
          return Text('Loading');
        }

      },
    );
  }
}
