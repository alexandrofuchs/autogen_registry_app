import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/new_registry_page.dart';

class RegistriesPage extends StatefulWidget {
  const RegistriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistriesPageState();
}

enum RegistryType {
  document,
  image,
  video,
}

class RegistryModel extends Equatable{
  final String filename;
  final String description;
  final String category;
  final DateTime dateTime;
  final RegistryType type;

  const RegistryModel({required this.filename, required this.description, required this.category, required this.dateTime, required this.type});
  
  @override
  List<Object?> get props => [
    filename,
    description,
    category,
    dateTime,
    type,
  ];

}

class _RegistriesPageState extends State<RegistriesPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets {
  @override
  void initState() {
    super.initState();
  }

  final list = <RegistryModel>[
    RegistryModel(filename: 'doc.pdf', description: 'Um arquivo pdf', category: 'estudos', dateTime: DateTime.now(), type: RegistryType.document),
    RegistryModel(filename: 'image.png', description: 'Um arquivo de imagem', category: 'estudos', dateTime: DateTime.now(), type: RegistryType.image),
    RegistryModel(filename: 'video.mp4', description: 'Um arquivo de video', category: 'estudos', dateTime: DateTime.now(), type: RegistryType.video),
  ];

  final fileIcons = <IconData>[
    Icons.picture_as_pdf,
    Icons.image,
    Icons.video_file_rounded,
  ];

  @override
  dispose() {
    super.dispose();
  }

  Widget footer() => GestureDetector(
        onTap: () {
          Navigator.of(context).push(_createRoute());
        },
        child: headerContainer('Adicionar novo arquivo'),
      );

  
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const NewRegistryPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottom(child: searchBar()),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: footer(),
      body: Column(
        children: [
          unselectedFilterBar(),
          divider(),
          ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => item(
              fileIcons[index], 'Um arquivo pdf.', '${list[index].category} | ${list[index].dateTime.toDaysNumberPast()}'),
          ),
        ],
      ),
    );
  }
}
