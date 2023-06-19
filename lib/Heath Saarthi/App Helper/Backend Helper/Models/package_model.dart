import 'package:flutter/material.dart';

class PackageItem {
  final String imageUrl;
  final String title;
  final String description;
  final String mrp;
  final String fMRP;

  PackageItem({required this.imageUrl, required this.title, required this.description,required this.mrp,required this.fMRP});
}

List<PackageItem> packageItems = [
  PackageItem(
    imageUrl: 'https://img.freepik.com/free-vector/fight-virus-concept_52683-36505.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Fight Virus',
    description: 'Description for Item 1',
    mrp: '450',
    fMRP: '355',
  ),
  PackageItem(
    imageUrl: 'https://img.freepik.com/free-vector/social-distancing-concept_52683-36538.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Social Distancing ',
    description: 'Description for Item 2',
    mrp: '450',
    fMRP: '375',
  ),
  PackageItem(
    imageUrl: 'https://img.freepik.com/free-vector/group-scientists-workers-holding-tubes_52683-35454.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Group Package',
    description: 'Description for Item 3',
    mrp: '555',
    fMRP: '500',
  ),
  PackageItem(
    imageUrl: 'https://img.freepik.com/free-vector/kids-playing-together-while-wearing-medical-masks_52683-36482.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Kids While Wearing Medical Mask',
    description: 'Description for Item 3',
    mrp: '750',
    fMRP: '650',
  ),
  PackageItem(
      imageUrl: 'https://img.freepik.com/free-vector/kids-playing-wearing-medical-masks_52683-36369.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
      title: 'Kids Package',
      description: 'Description for Item 3',
      mrp: '450',
      fMRP: '300'
  ),
];
