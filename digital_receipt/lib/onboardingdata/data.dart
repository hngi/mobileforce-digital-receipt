class SliderModel{

  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath,this.title,this.desc});

  void setImageAssetPath(String getImagepath){
    imagePath = getImagepath;
  }
  void setTile(String getTitle){
    title = getTitle;
  }
  void setDesc(String getDesc){
    desc = getDesc;
  }
  String getImageAssetPath(){
    return imagePath;
  }
  String getTitle(){
    return title;
  }
  String getDesc(){
    return desc;
  }
}

List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImageAssetPath("assets/images/receipt1.png");
  sliderModel.setTile("Create digital receipts");
  sliderModel.setDesc("Create digital receipts for sales on the go. Quick,easy fast process");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImageAssetPath("assets/images/track1.png");
  sliderModel.setTile("Track sales");
  sliderModel.setDesc("Keep a tab of all your sales and receipts"
      "with our handy analytics tools");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImageAssetPath("assets/images/socialshare1.png");
  sliderModel.setTile("Social Share");
  sliderModel.setDesc("Share receipts with ease via social media");
  slides.add(sliderModel);

  return slides;
}