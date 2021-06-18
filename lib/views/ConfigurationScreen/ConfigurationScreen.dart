import 'package:flutter/material.dart';
import '/core/core.dart';

import 'package:beco_passenger/shared/widgets/ArrowButtonWidget.dart';
import 'package:beco_passenger/shared/widgets/InfoCardAccountWidget.dart';
import 'package:beco_passenger/shared/widgets/InfoCardWidget.dart';

class ConfigurationScreen extends StatefulWidget {
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;
    final double heightMargin = MediaQuery.of(context).size.height / 42;
    final double heightMarginTitle = MediaQuery.of(context).size.width / 11;

    final String config = "Configurações";
    final String account = "Conta";
    final String userName = "David Clerisseau";
    final String userInfo = "Informação Pessoal";
    final String language = "Idioma";
    final String notifications = "Notificações";
    final String darkMode = "Modo Noturno";

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: widthMargin, top: heightMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: IconButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                ),
              ),
              SizedBox(height: heightMarginTitle),
              Padding(
                padding: EdgeInsets.only(left: widthMargin * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(config, style: AppTextStyles.upTitle),
                    SizedBox(height: 5),
                    Container(
                      width: 30,
                      height: 2,
                      color: Colors.blue,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 37),
                        child: Text(account, style: AppTextStyles.subTitle20)),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 32, bottom: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoCardAccountWidget(
                            userName,
                            userInfo,
                            AppImages.faceLight,
                          ),
                          Expanded(child: SizedBox()),
                          ArrowButtonWidget(() => {}),
                        ],
                      ),
                    ),
                    // SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(config, style: AppTextStyles.subTitle20),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InfoCardWidget(language, AppImages.languageLight),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child:
                                Text("Português", style: AppTextStyles.text10),
                          ),
                          ArrowButtonWidget(() => {}),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InfoCardWidget(
                              notifications, AppImages.notificationLight),
                          Expanded(
                            child: SizedBox(),
                          ),
                          ArrowButtonWidget(() => {}),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InfoCardWidget(darkMode, AppImages.moonLight),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text("Off", style: AppTextStyles.text10),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Switch(
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                              activeColor: Color(0xff545FFF),
                              inactiveTrackColor: Color(0xffF5F5F7),
                              inactiveThumbColor: Color(0xffF5F5F7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
