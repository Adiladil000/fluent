part of 'login_view.dart';

TextFormField emailTextFromField(TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (checkEmail(value)) {
        return "Check your email";
      }
      return null;
    },
    controller: controller,
    decoration: InputDecoration(
      hintText: TextConstants.email,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      filled: true,
      fillColor: ColorContants.fillColor,
      hintStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

bool checkEmail(String? value) => value == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
