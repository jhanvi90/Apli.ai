// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class NameSearch extends SearchDelegate<String> {
//
//   CollectionReference reference = FirebaseFirestore.instance.
//   collection('AddProducts').doc(FirebaseAuth.instance.currentUser.uid).collection('Product');
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return
//       IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context)
//   {
//     return StreamBuilder<QuerySnapshot>(
//         stream: reference.snapshots(),
//         builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot)
//         {
//           if(!snapshot.hasData)
//             {
//               return Center(child: CircularProgressIndicator());
//             }
//           else{
//             if(snapshot.data.docs.where((QueryDocumentSnapshot<Object> element) =>
//                 element ['itemName'].toString().toLowerCase().contains(query.toLowerCase())).isEmpty)
//               {
//                 return
//               }
//             return ListView(
//               children: [
//                 ...snapshot.data.docs.where((QueryDocumentSnapshot<Object> element) =>
//                 element ['itemName'].toString().toLowerCase().contains(query.toLowerCase()))
//                     .map((QueryDocumentSnapshot<Object> data)
//                 {
//                     final String title = data.get('itemName');
//                     return ListTile(title: Text(title),);
//                 }),
//               ],
//             );
//           }
//         });
//
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//
//     return Text("serach");
//   }
// }



import 'package:flutter/material.dart';

class NameSearch extends SearchDelegate<String> {
  final List names;

  String result;

  NameSearch(this.names);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("namessss");
    print(names[0]['itemName']);
    final suggestions = names.where((name) {
      return name.itemName.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
              suggestions[index].itemName
          ),
          onTap: () {
            result =  suggestions[index].itemName;
            print("sbhsgbd");
            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = names.where((name) {
      return name['itemName'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
       return ListView.builder(
        itemCount: suggestions.length,
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
                        child: CircleAvatar(
                          backgroundImage: suggestions[index]['url']==null?Container():
                          NetworkImage(suggestions[index]['url']),
                        ),
                      ),
                      title:Text(suggestions[index]['itemName']),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(suggestions[index]['price']+" Rs"),
                          Container(
                            height: 50,width: 100,
                            child: RaisedButton(
                                onPressed: (){},
                                color: Colors.black,
                                child: Text("Stock\n${suggestions[index]['stockUnit']}"+" "+"${suggestions[index]['stockQty']}",style: TextStyle(color: Colors.white),)),
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
