import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                const Text("⚫ About Us",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.indigo)),
                const Text("    "),
                const Text(
                    "Connecting Similar Patient to make more Energetic🧘",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal)),
                const Text("    "),
                RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.pink),
                      text: "   MediNet ",
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      text:
                      "is a free Health community application that helps you find, "
                          "share health & disease related information in the Indian Context. "
                          "The idea is that you can make better health decisions using information "
                          "and support gained by discussing your health experiences with "
                          "others.",
                    )
                  ]),
                ),
                const Text(
                  "     Here you can easily search for any medical condition, symptom,"
                      " drug or treatment and learn from the valuable experiences of millions"
                      " of other patients. Our dedicated community members are helping thousands"
                      " of patients like you every day.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const Text("    "),
                RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.pink),
                      text: "   Our Mission:",
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      text:
                      " To develop of an interactive and easy to use interface"
                          " for the users community We believe in the power of community to"
                          " improve the lived experience of patients managing complex health"
                          " conditions. Our purpose is to create a trusted digital platform that"
                          " empowers patients to navigate their health journeys together through"
                          " peer support, personalized health insights, tailored digital health services"
                          " and patient-friendly clinical education."
                          " Our health community application aims to provide a platform"
                          " for individuals to access reliable health information, connect"
                          " with healthcare providers, and engage in a supportive community"
                          " that promotes healthy behaviors and lifestyles."
                          "",
                    )
                  ]),
                ),
                const Text("    "),
                RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.pink),
                      text: "   Our Vision:",
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      text: " To create a world where every"
                          " individual has access to the knowledge and"
                          " resources they need to make informed decisions"
                          " about their health and well-being. We strive to be"
                          " the leading platform for health education, collaboration,"
                          " and community-building, empowering individuals to take"
                          " charge of their own health and live their best lives.",
                    )
                  ]),
                ),
                const Text("    "),
                RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.pink),
                      text: "   Why Us:",
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      text:
                      "We developed a patient community app which unique in our "
                          "society the people in groups helps to share their experience about "
                          "their medical case and their solution on our platform Because there "
                          "is no diseases are unique, so you can share how did you get cure of that "
                          "specific disease Because in the real world people have no choice. Our community "
                          "is about finding each other and a place we can call home. But we are also "
                          "compelled to build community not only because we are survivors in an existing "
                          "world order but because we bring differences to a society that erases our "
                          "differences. By dealing with differences we confront the question of the social "
                          "and economic foundations of our society. By building community we put some order "
                          "in the fragmented world.",
                    )
                  ]),
                ),
                const Text(""),
                const Text(
                  "     We’re committing MediNet to help increase the collective health, openness, "
                      "and civility of public conversation, and to hold ourselves "
                      "publicly accountable towards progress.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ])),
        ));
  }
}