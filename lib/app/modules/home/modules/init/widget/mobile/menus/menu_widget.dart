import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/menu.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

class MenuWidget extends StatelessWidget {
  Menu menu;


  MenuWidget(this.menu);

  @override
  Widget build(BuildContext context) {
    return Container(


    child: Container(

        height: 100,width: 140,
        child: Card(

            child: InkWell(
                onTap: () {
                  if(menu.route == ConstantsRoutes.EXIT){
                    Modular.get<LoginBloc>().getLogout();
                  }else{
                    Modular.to.pushNamed(
                        menu.route);
                  }

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      menu.icon,
                      color: AppThemeUtils.colorPrimary, size: 35,
                    ),
                    SizedBox(
                      height: menu.title != null ? 5 : 10,
                    ),
                    menu.title != null
                        ? Container(
                        child: Center(
                            child: Text(
                              menu.title,
                              textAlign: TextAlign.center,
                              style: AppThemeUtils.normalSize(
                                  color: AppThemeUtils.colorPrimary,
                                  fontSize: 16),
                            )))
                        : SizedBox(),
                    SizedBox(
                      height: menu.title != null ? 5 : 0,
                    ),
                    // Container(
                    //     margin: EdgeInsets.symmetric(horizontal: 20),
                    //     child: Center(
                    //         child: Text(
                    //           subtitle,
                    //           textAlign: TextAlign.center,
                    //           style: AppThemeUtils.normalSize(
                    //               color: colorText ?? colorIcon, fontSize: 16),
                    //         )))
                  ],
                )))));
  }
}
