import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectdetailscubit.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:untitled4/Custom_widget/subjectdetailswidget.dart/topprofilesubject.dart';
import 'package:untitled4/Model/subjectmodel.dart';
import 'package:untitled4/Model/unitmodel.dart';
import 'package:untitled4/Screen/pdf.dart';
import 'package:untitled4/Screen/unitdetails.dart';
import 'package:untitled4/constans.dart';
import '../Cubit/Subject cubit/subjectdetailsstates.dart';

class subjectdetails extends StatelessWidget {
  subjectdetails({super.key, required this.model});
  Subjectmodel? model;

  @override
   @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(model!.name),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          const pinkled(550, 20),
          const BlueLed(30, 255),
          ListView(
            children: [
              topprofilesubject(Userdata: model),
              Padding(
                padding: const EdgeInsets.only(top: 26.0, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('About : '), Text(model!.aboutsubject)],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 36.0, left: 30),
                child: Text('Units: '),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                    height: 102,
                    child:
                        BlocBuilder<subjectdetailscubit, subjectdetailsstate>(

                      builder: (context, state) {

                        Set<unitmodel> listunit =
                            BlocProvider.of<subjectdetailscubit>(context)
                                .unitlist;

                        if (state is initialstatedetails) {

                          return ListView.builder(
                            itemExtent: 100,
                            scrollDirection: Axis.horizontal,
                            itemCount: listunit.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return unitdetails(
                                          model: listunit.toList()[index],
                                        );
                                      }));
                                    },
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: 'http://$KURL:8000${listunit.toList()[index].photopath}',
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => CircleAvatar(
                                           radius: 40,
                                          child: Icon(Icons.error , color: Colors.red , size: 80, )),
                                      imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: imageProvider
                              ),)


                                  ),
                                  Text(
                                      'unit ${listunit.toList()[index].unitnumber}')
                                ],
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.pink,
                          ));
                        }
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('book pdf :'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PDFViewerFromUrl(
                              title: '${model!.name} book',
                              url: 'http://$KURL:8000${model!.bookpath}');
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.withOpacity(.2)),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('book'),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
