import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

void main() {
  runApp(const MaterialApp(
    home: AppLauncher()
  ));
}

class AppLauncher extends StatefulWidget {
  const AppLauncher({ Key? key }) : super(key: key);

  @override
  State<AppLauncher> createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  int _selectedIndex = 1;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[showSchedules(),homeScreen(),addTask()];
    return Scaffold(
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        items: <Widget>[
          Icon(Icons.list,),
          Icon(Icons.home),
          Icon(Icons.add),
        ],
        index: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex=i;
          });
        }
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget homeScreen() {
    return Column(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              'What to do?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40
              ),
            ),
          ),
          Center(
            child: Ink(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
            ), // LinearGradientBoxDecoration
            child: InkWell(
                onTap: () {
                  // setState(() {
                  //   showAppBar = !showAppBar;
                  // });
                },
                customBorder: CircleBorder(),
                child: Center(child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Java',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[200]
                        )
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('for 35 mins')
                    ],
                  )
                ),
                splashColor: Colors.greenAccent,
              ),
            )
          )
        ],
      );
  }

  Widget showSchedules() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          height: 50,
          child: Center(
            child: Text("Scheduled",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
            ),
          ),
          color: Colors.yellowAccent,
        ),
        Container(
          child:
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context,index) {
                //final item = items[index];
                final item = "Java";
                return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      //items.removeAt(index);
                    });

                    // Then show a snackbar.
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$item dismissed')));
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red,child: Text("Discard"),),
                  child:ListTile(
                    leading: Container(margin: EdgeInsets.only(top: 12),child:Text('10:30 pm',style: TextStyle(color: Colors.black),),),
                    title: Container(margin: EdgeInsets.only(left: 20),child:Text("Java",style: TextStyle(color: Colors.black),),),
                    subtitle: Container(margin: EdgeInsets.only(left: 20),child:Text("Session Time : 32mins",style: TextStyle(color: Colors.black,fontSize: 12),),),
                    trailing: Text("20/03/22",style: TextStyle(color: Colors.white),),
                    tileColor: Colors.white,
                  )
                );
              }
            ),
          margin: EdgeInsets.symmetric(horizontal: 5),
        ),
      ]
    );
  }

  Widget addTask() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
        Column(
          children: [
            SizedBox(
            height: 40,
          ),
            TextFormField(
            decoration: InputDecoration(
              label: Center(child: Text("Task Name",
                style: TextStyle(
                  color: Colors.white
                  ),
                ),
              ),
              hintText: "Eg: Java",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              )
            ),
          ),
            SizedBox(
              height: 15,
            ),
            Center(
            child: 
            Text("Deadline:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
            SizedBox(
              height: 10,
            ),
            DateTimeFormField(
              dateTextStyle: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.redAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0.0),
                ),
                suffixIcon: Icon(Icons.event_note,color:Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Enter deadline',
              ),
              mode: DateTimeFieldPickerMode.dateAndTime,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                print(value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child:
              Text("Session Time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 0.45*MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Center(child: Text("Hours",
                        style: TextStyle(
                          color: Colors.white
                          ),
                        ),
                      ),
                      hintText: "00",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.45*MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Center(child: Text("Mins",
                        style: TextStyle(
                          color: Colors.white
                          ),
                        ),
                      ),
                      hintText: "00",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                    ),
                  ),
                ),
              ]
            ),         
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child:
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(Icons.done),
                onPressed: (){

                }
              )
            ),
        ),
      ]),
    );
  }

}