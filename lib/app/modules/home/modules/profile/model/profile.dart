class Profile {
  String name;
  String imageProfileUrl;
  String imageCompanyUrl;
  String registration;
  String company;
  double benefit;
  String email;

  String facebook;
  String instagram;

  List<String> preferences;

  Profile(
      {this.name,
      this.imageProfileUrl,
      this.imageCompanyUrl,
      this.registration,
      this.company,
      this.benefit,
      this.email,
      this.facebook,
      this.instagram,
      this.preferences});
}
