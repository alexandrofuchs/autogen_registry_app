part of 'registry_groups_page.dart';

mixin RegistryGroupsWidgets on CommonWidgets {
  Widget groupWidget(BuildContext context, RegistryGroupsProvider provider,
          int groupIndex) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              AppRouter.route(
                  HomeWorflow.openedRegistryGroupPage(
                      provider.groups[groupIndex]),
                  transition: RouteTransition.rightToLeft));
        },
        child: Container(
            margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryColorDark,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(50)),
              border: Border.all(color: AppColors.primaryColorLight, width: 1.5),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(child: titleDot(provider.groups[groupIndex])),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.secundaryColor,
                  ),
                ),
              ],
            )),
      );

  Widget loadedGroups(RegistryGroupsProvider provider) => RefreshIndicator(
      onRefresh: () async {
        await provider.load();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(15),
        child: provider.groups.isEmpty
            ? ListView(
              shrinkWrap: true,
              children: [Center(
                  child: Container(
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.primaryColorLight, width: 3),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        color: AppColors.primaryColorDark),
                    padding: const EdgeInsets.all(15),
                    child: const Text('Nenhum grupo criado',
                        style: AppTextStyles.labelStyleLarge),
                  ),
                )]
            )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: provider.groups.length,
                itemBuilder: (context, groupIndex) =>
                    groupWidget(context, provider, groupIndex),
              ),
      ));
}
