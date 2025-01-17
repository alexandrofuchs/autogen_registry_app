import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

class RegistriesPage extends StatefulWidget {
  const RegistriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistriesPageState();
}

class _RegistriesPageState extends State<RegistriesPage> {
  get child => null;

  Widget backgroundWidget() => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColorDark.withAlpha(115),
                    AppColors.primaryColor.withAlpha(115),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 1,
                    color: Colors.black.withAlpha(200),
                  ),
                  BoxShadow(
                    color: AppColors.secundaryColor,
                  )
                ]),
            height: 100,
          ),
          Container(
            height: 50,
            color: AppColors.backgroundColor,
          )
        ],
      );


  Widget searchBar() => 
    Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                cursorColor: AppColors.primaryColorDark,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search',
                    labelStyle: TextStyle(
                      backgroundColor: AppColors.primaryColorDark,
                    )),
                style: TextStyle(
                    decorationColor: AppColors.primaryColorDark,
                    color: AppColors.primaryColorDark),
              ),
            ),
          ],
        ),
      );
          

  PreferredSize appBarBottom() => PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          backgroundWidget(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.secundaryColor,
             borderRadius: BorderRadius.circular(5),
             boxShadow: [
              BoxShadow(
                color: AppColors.primaryColorDark,
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: -2
              )
             ]
            ),
            margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
            child: searchBar(),
          )
        ],
      ));
  
  Widget divider() =>
    const Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Divider(),
          );

  Widget item(IconData icon, String title) =>
    Container(
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
            decoration: BoxDecoration(
              color: AppColors.secundaryColor,
              border: Border.all(color: AppColors.primaryColorDark, width: 0.5),
            ),
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Icon(icon),
              const SizedBox(width: 15),
              Text(title, style: AppTextStyles.bodyStyleSmall,),
            ],),
          );

  Widget filterBar() =>
    Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColorDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: AppColors.primaryColorDark),
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Text('docs', style: AppTextStyles.labelStyleSmall),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottom(),
      ),
      body: Column(
        children: [
          filterBar(),
          divider(),
          ListView(
            shrinkWrap: true,
            children: [
              item(Icons.picture_as_pdf, 'Um arquivo pdf.'),
              item(Icons.video_camera_back, 'Um outro arquivo em video.'),
              item(Icons.image, 'Um outro arquivo em imagem.'),
            ],
          ),
        ],
      ),
    );
  }
}
