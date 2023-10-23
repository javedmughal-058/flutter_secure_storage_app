import 'package:flutter/material.dart';
import 'package:flutter_secure_storage_app/utils/user_secure_storage.dart';
import 'package:flutter_secure_storage_app/widget/birthday_widget.dart';
import 'package:flutter_secure_storage_app/widget/button_widget.dart';
import 'package:flutter_secure_storage_app/widget/pets_buttons_widget.dart';
import 'package:flutter_secure_storage_app/widget/title_widget.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  DateTime? birthday;
  List<String> interests = [];
  @override
  void initState() {
    super.initState();
    init();

  }

  Future init() async {
    final name = await SecureStorage.getName() ?? '';
    final birthday = await SecureStorage.getBirthday();
    final pets = await SecureStorage.getPets() ?? [];

    setState(() {
      controllerName.text = name;
      this.birthday = birthday;
      interests = pets;
    });
  }


  @override
  Widget build(BuildContext context){
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const TitleWidget(icon: Icons.lock, text: 'Secure\nStorage'),
            SizedBox(height: size.height* 0.01),
            buildName(),
            SizedBox(height: size.height* 0.01),
            buildBirthday(),
            SizedBox(height: size.height* 0.01),
            buildPets(),
            SizedBox(height: size.height* 0.02),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildName() => buildTitle(
        title: 'Name',
        child: TextFormField(
          controller: controllerName,
          cursorColor: Theme.of(context).cardColor,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).cardColor),
            ),
            enabled: true,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).cardColor),
            ),
            hintText: 'Your Name',
          ),
        ),
      );

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this.birthday = birthday),
        ),
      );

  Widget buildPets() => buildTitle(
        title: 'Developer',
        child: PetsButtonsWidget(
          interests: interests,
          onSelectedPet: (pet) => setState(() => interests.contains(pet) ? interests.remove(pet) : interests.add(pet)),
        ),
      );

  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await SecureStorage.setName(controllerName.text);
        await SecureStorage.setPets(interests);
        if (birthday != null) {
          await SecureStorage.setBirthday(birthday!);
        }
        Future.delayed(const Duration(milliseconds: 500),(){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              showCloseIcon: true,
              closeIconColor: Theme.of(context).scaffoldBackgroundColor,
              content: const Text('Record Saved to Secure Storage')));
        });
      });

  Widget buildTitle({required String title, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );


}
