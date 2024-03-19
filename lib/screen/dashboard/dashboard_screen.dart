import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety/helper/message_dao.dart';
import 'package:women_safety/util/size.util.dart';
import 'package:women_safety/util/theme/app_colors.dart';
import 'package:women_safety/util/theme/text.styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<bool> allStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Future<void> openNewLink(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: Text('Load Control ', style: sfProStyle400Regular.copyWith(fontSize: 14, color: Colors.white)),
      //     centerTitle: true,
      //     backgroundColor: colorPrimary),
      body: SafeArea(
        child: StreamBuilder(
            stream: MessageDao.messagesRef.onValue,
            builder: (c, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              snapshot.data!.snapshot.child('INTACT_POWER').children.forEach((element) {
                int position = int.parse(element.key!.replaceAll('device_', ''))-1;
                bool value = int.parse(element.value.toString()) == 1;
                allStatus[position] = value;
              });

              return Builder(builder: (context) {
                return Column(
                  children: [
                    Container(
                      width: getAppSizeWidth(),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: colorPrimary, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                      child: Text('Welcome, AC Control Systems', style: sfProStyle500Medium.copyWith(fontSize: 15, color: Colors.white)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 25,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        itemBuilder: (context,index){
                          return buildEachRow(allStatus[index], 'device_${index+1}',index);
                        },

                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: (){
                          openNewLink('https://sites.google.com/view/mehedihasanshuvo');
                        },
                        child: Center(child: Text("Developed by Mehedi Hasan Shuvo.", style: sfProStyle400Regular.copyWith(fontSize: 16)))),
                    const SizedBox(height: 20),
                  ],
                );
              });
            }),
      ),
    );
  }

  Widget buildEachRow(bool status, String path,int index) {
    return eachRow(
      "Device ${index>8?'':'0'}${index+1}",
      "OFF",
      widget: Container(
        height: 18,
        width: 20,
        alignment: Alignment.centerRight,
        child: Switch(
            onChanged: (bool value) {
              MessageDao.messagesRef.ref.child("INTACT_POWER").update({path: status ? 0 : 1});
            },
            value: status,
            activeColor: Colors.white,
            activeTrackColor: colorPrimary),
      ),
    );
  }

  Widget eachRow(String key, String value, {Widget? widget}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(border: Border.all(color: colorIcons.withOpacity(.6)), borderRadius: BorderRadius.circular(4)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(key, style: sfProStyle600SemiBold.copyWith(fontSize: 14, color: Colors.black))),
            VerticalDivider(color: colorIcons.withOpacity(.6), thickness: 1.1),
            Expanded(child: widget ?? Text(value, textAlign: TextAlign.end, style: sfProStyle400Regular.copyWith(fontSize: 16, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
