part of "login_view.dart";

TextFormField passwordTextFromField(TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Password is empty";
      } else if (value.length < 6) {
        return "Should be atleast 6 characters";
      }
      return null;
    },
    controller: controller,
    decoration: InputDecoration(
      hintText: TextConstants.password,
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
