import '/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextFormField {
  static textFormField(
      {required BuildContext context,
      required String titleText,
      TextEditingController? controller,
      String? hintText,
      TextInputType? keyboardType,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      String obscuringCharacter = '•',
      String? Function(String?)? validator,
      bool readOnly = false,
      void Function()? onTap,
      Iterable<String>? autofillHints,
      double? topPadding,
      int? maxLength,
      int? maxLines = 1,
      int? minLines,
      Color? color,
      bool? shadowWant = false,
      void Function(String)? onChanged,
      InputBorder? border}) {
    return TextFormField(
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        autofillHints: autofillHints,
        cursorOpacityAnimates: true,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: validator,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: onChanged,
        minLines: minLines,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            border: border ??
                OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xffEFE9E9), strokeAlign: 1),
                    borderRadius: BorderRadius.circular(32.0.r)),
            enabledBorder: border ??
                OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xffEFE9E9), strokeAlign: 1),
                    borderRadius: BorderRadius.circular(32.0.r)),
            focusedBorder: border ??
                OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xffEFE9E9), strokeAlign: 1),
                    borderRadius: BorderRadius.circular(32.0.r)),
            fillColor: color ?? const Color(0xffE4ECFF).withOpacity(0.30),
            filled: true,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.bodyLarge
                ?.copyWith(fontSize: 14.sp, color: const Color(0xffA9A9A9))),
        controller: controller);
  }
}
 //this hide code for password text field.


//  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);


// ValueListenableBuilder(
//             valueListenable: _obsecurePassword,
//             builder: (context, value, child) {
//               return TextFormField(
//                 obscureText: _obsecurePassword.value,
//                 obscuringCharacter: "*",
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock_open_rounded),
//                   suffixIcon: InkWell(
//                       onTap: () {
//                         _obsecurePassword.value = !_obsecurePassword.value;
//                       },
//                       child: Icon(_obsecurePassword.value
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility)),
//                 ),
//               );
//             }),