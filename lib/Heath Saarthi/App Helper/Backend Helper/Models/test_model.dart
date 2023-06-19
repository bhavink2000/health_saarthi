import 'package:flutter/material.dart';

class TestItem {
  final String imageUrl;
  final String title;
  final String description;
  final String mrp;
  final String fMRP;

  TestItem({required this.imageUrl, required this.title, required this.description,required this.mrp,required this.fMRP});
}

List<TestItem> testItems = [
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/horizontal-science-banner-with-glass-containers_23-2149495075.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Cardiac enzymes',
    description: 'Description for Item 1',
    mrp: '450',
    fMRP: '355',
  ),
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/horizontal-science-banner-with-glass-containers_23-2149495026.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Cholesterol and lipid tests',
    description: 'Description for Item 2',
    mrp: '450',
    fMRP: '375',
  ),
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/laboratory-glassware-microscope-arrangement_23-2149731531.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Erythrocyte sedimentation rate (ESR) test.',
    description: 'Description for Item 3',
    mrp: '555',
    fMRP: '500',
  ),
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/laboratory-glassware-with-green-background_23-2149731528.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'HbA1c test.',
    description: 'Description for Item 3',
    mrp: '750',
    fMRP: '650',
  ),
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/side-view-hand-holding-tube_23-2149731472.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Calcium blood test.',
    description: 'Description for Item 3',
    mrp: '450',
    fMRP: '300'
  ),
  TestItem(
    imageUrl: 'https://img.freepik.com/free-photo/minimalistic-science-banner-with-sample_23-2149431100.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266',
    title: 'Magnesium blood test.',
    description: 'Description for Item 3',
    mrp: '200',
    fMRP: '150'
  ),
];
