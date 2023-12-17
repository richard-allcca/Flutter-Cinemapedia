

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon});
}

const appMenuItems = <MenuItem>{
  MenuItem(
    title: 'home',
    subTitle: 'subtitle home',
    link: '/',
    icon: Icons.home_max_outlined
  ),
};