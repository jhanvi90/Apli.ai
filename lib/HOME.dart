import 'package:apliee/AllProducts.dart';
import 'package:apliee/prdroductSerach.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeInvatary extends StatefulWidget {
  const HomeInvatary({Key key}) : super(key: key);

  @override
  _HomeInvataryState createState() => _HomeInvataryState();
}

class _HomeInvataryState extends State<HomeInvatary>
{
  var firebaseUser = FirebaseAuth.instance.currentUser;

  checkIds() async {
    await onSerach();
  }
  List datassss=[];
  TextEditingController name = TextEditingController();
  Widget productsWidegt()
  {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("AddProducts").
        doc(firebaseUser.uid).collection("Product").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No images found!!"),
            );
          }
          else if(snapshot.hasData){
            datassss=snapshot.data.docs.toList();
            if(name.text.toString().isEmpty)
              {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context,int index){
                      return
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Container(
                                    height: 60,width: 60,
                                    child: snapshot.data.docs[index]['url']==null?Container():CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data.docs[index]['url']),
                                    ),
                                  ),
                                  title:Text(snapshot.data.docs[index]['itemName']+snapshot.data.docs[index]['itemName']),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data.docs[index]['price']+" Rs"),
                                      Container(
                                        height: 50,width: 100,
                                        child: RaisedButton(
                                            onPressed: (){},
                                            color: Colors.black,
                                            child: Text("Stock\n${snapshot.data.docs[index]['stockUnit']}"+" "+"${snapshot.data.docs[index]['stockQty']}",style: TextStyle(color: Colors.white),)),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 50,)
                            ],
                          ),
                        );


                    }
                );
              }

          }
        });
  }

  CollectionReference reference = FirebaseFirestore.instance.collection('AddProducts')
      .doc(FirebaseAuth.instance.currentUser.uid).collection('Product');

  List userMap;
  Future<void> onSerach() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('AddProducts')
        .doc(FirebaseAuth.instance.currentUser.uid).collection('Product')
        .where("itemName",isEqualTo: name.text).get().then((value)
    {
      print(value.docs.length);
      for(var i=0;i<value.docs.length;i++)
        {
          value.docs[i].data().forEach((key, value) {
            userMap.add(key);
          });
          // setState(() {
          //   userMap= value.docs[i].data();
          // });
          print(value.docs[i].data());
        }

        print("usreeeeeeeeeeeee");
      //  print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("My Product"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
            color: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => upload()),);
            },
            child: Text("Add Product",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
      body: Column(
        children: [
      TextField (
        controller: name,
     onTap: (){
          print(datassss[0]['price']);
       showSearch<String>(
         context: context,
         delegate: NameSearch(
             datassss
             ),
       );
     },
      decoration: InputDecoration(
      border: InputBorder.none,
          labelText: 'Enter Name',
          hintText: 'Enter Your Name',
      ),
    ),
      Expanded(child:productsWidegt())
    ],
      ),
    );
  }
}


