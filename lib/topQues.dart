import 'package:flutter/material.dart';
class Top extends StatefulWidget {
  final int i;
  const Top({Key? key,required this.i}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  List<String> ques=["What is it like to be a doctor? What do they think of their patients?",
    "We does receive great respect from our patients though, and I guess that medical practitioners are among the "
        "last who still get some praise for what they do.It is very common that we receives flowers, wine, champagne "
        "or bonbons from grateful patients, and even many years after a final consultation or surgery, she is often "
        "addressed on the street by former patients.On the other hand, we sometimes is forced to bring very bad news."
        "Telling a 24-years-old mother that she has terminal cancer, explaining someone that the therapy does not "
        "work and that all options are out, having to face an occasional complication — it all comes with the job. "
        "And it can be highly unpleasant, and very emotional for herself as well.And then there is also the verbally "
        "aggressive patients, who enter the consultation room with a firm conviction about what they actually have, "
        "self-diagnosed with the help of dr. Google.Usually these people need a psychiatrist, and not a urologist.",
  "Age when a baby can drink cows' milk?",
    "Babies can start drinking cow's milk as a main drink at 12 months old. Before that, breast milk or formula "
        "should be the main source of nutrition.",
  "How can a healthy diet help in preventing diabetes?",
    "Whole Grains: Whole grains, such as brown rice, quinoa, whole-wheat bread, and oatmeal, are rich in fiber and "
        "other nutrients and can help regulate blood sugar levels.Non-Starchy Vegetables: Non-starchy vegetables, such "
        "as broccoli, spinach, kale, carrots, and peppers, are low in calories and high in fiber, vitamins, and "
        "minerals. They are also low in carbohydrates and have a minimal impact on blood sugar level.Lean Proteins: "
        "Lean proteins, such as chicken, turkey, fish, eggs, tofu, and legumes, can help regulate blood sugar levels "
        "and provide important nutrients without raising blood sugar levelsLow-Glycemic Fruits: Low-glycemic fruits, "
        "such as berries, cherries, apples, and oranges, are low in carbohydrates and can help regulate blood sugar "
        "levels.It's important to work with a registered dietitian(Fit-Diet Solutions) or a healthcare professional "
        "to develop an individualized meal plan that meets your specific needs and goals. In addition to a healthy "
        "diet, regular physical activity and medication management (if prescribed) are important components of "
        "diabetes management.",
    "Is it okay to have green tea on an empty stomach?",
    "Green tea is loaded with vitamins and minerals. It is rich in vitamin E as an antioxidant and minerals like "
        "potassium, calcium, phosphorus and magnesium.",
    "Do you think there is another pain equal to childbirth?",
    "I have no personal experience, but my wife says childbirth wasn’t nearly as painful as she’d been told. She "
        "delivered two babies without anesthesia and compared it to the last few miles of a marathon.",
        "Best remedies for the fever which is not last upto 10 days.",
    "It is important to seek medical attention if a fever lasts for more than 10 days. To manage fever symptoms in "
        "the short term, it is recommended to stay hydrated, rest, take over-the-counter fever reducers, take a "
        "sponge bath, dress lightly, and use a cool compress. Consult a healthcare professional if the fever "
        "persists for more than a few days or if severe symptoms occur.",
        "What are some natural remedies for migraines?",
"Natural remedies for migraines include resting in a quiet room, applying a cold or warm compress, relaxation "
    "techniques, staying hydrated, applying essential oils, acupuncture, avoiding triggers, regular exercise, "
    "consistent sleep schedule, and keeping a headache diary. Consult with a healthcare professional for proper "
    "diagnosis, treatment, and personalized advice.",
        "How can I improve my sleep quality?",
    "Improving sleep quality is essential for overall well-being. To improve sleep quality, it is important to stick "
        "to a consistent sleep schedule, create a bedtime routine, create a sleep-friendly environment, limit "
        "exposure to electronic devices, avoid stimulating substances, exercise regularly, create a comfortable "
        "sleep environment, manage stress, avoid large meals and excessive fluid intake before bedtime, and consult "
        "a healthcare professional. These tips can significantly improve sleep quality over time, but it is important "
        "to remember that everyone's sleep needs are different.",
        "What are the symptoms and treatments for anxiety disorders?",
    "Anxiety disorders are a range of conditions characterized by excessive worry, fear, and apprehension. Common "
        "symptoms include excessive worry, restlessness, physical symptoms, panic attacks, sleep disturbances, "
        "cognitive symptoms, and avoidance behaviors. Treatment options include therapy, medication, lifestyle "
        "modifications, support network, and stress reduction techniques. Consulting with a mental health professional"
        " is essential for accurate diagnosis, personalized treatment planning, and ongoing support.",
        "Is there a cure for chronic back pain?",
  "Chronic back pain is a persistent or recurring pain in the back that lasts for an extended period, typically more "
      "than three months. There are various treatment options available to manage the symptoms and improve the quality"
      " of life. Conservative treatments include physical therapy, pain medications, heat or cold therapy, lifestyle "
      "modifications, alternative therapies, interventional procedures, and surgical options. It is important to "
      "consult with a healthcare professional to evaluate the condition, provide an accurate diagnosis, and recommend "
      "the most appropriate treatment options."];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Post"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Divider(thickness: 5,color: Colors.purple,),
            Text(ques[widget.i],
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  decorationColor: Colors.red,
                )),
            const Divider(thickness: 5,color: Colors.black,),
            Text(ques[widget.i+1],style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
