import 'package:digital_receipt/constant.dart';
import 'package:flutter/cupertino.dart';

class SliderModel {
  Widget image;
  String title;
  String desc;

  SliderModel({this.image, this.title, this.desc});

  void setImageAssetPath(Widget getImagepath) {
    image = getImagepath;
  }

  void setTile(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  Widget getImageAssetPath() {
    return image;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImageAssetPath(kOnboarding);
  sliderModel.setTile("Create digital receipts");
  sliderModel.setDesc(
      "Create digital receipts for sales on the go. Quick,easy fast process");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImageAssetPath(kOnboarding2);
  sliderModel.setTile("Track sales");
  sliderModel.setDesc("Keep a tab of all your sales and receipts"
      "with our handy analytics tools");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImageAssetPath(kOnboarding1);
  sliderModel.setTile("Social Share");
  sliderModel.setDesc("Share receipts with ease via social media");
  slides.add(sliderModel);

  return slides;
}
