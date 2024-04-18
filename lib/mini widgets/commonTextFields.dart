// ignore_for_file: null_check_always_fails

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFields extends StatelessWidget {
  const CommonTextFields(
      {super.key,
      required this.controllerValue,
      required this.labelName,
      this.prefixIcon,
      required this.sufficIcon, required this.obscureEnabled, required this.obscurePresent, this.hintText});
  final String labelName;
  final TextEditingController controllerValue;
  final Icon? prefixIcon;
  final Icon? sufficIcon;
  final bool obscureEnabled;
  final bool ?obscurePresent;
  final String ? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      height: 40.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
             padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
            child: Text(
              labelName,
              style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
             padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 5.h),
            child: SizedBox(
              height: 20.h,
              child: TextFormField(
                controller: controllerValue,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                cursorHeight: 12.h,
                decoration: InputDecoration(
                  
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                  prefixIcon: prefixIcon,
                  prefixIconColor: Colors.grey,
                  suffixIcon: sufficIcon,
                  hintText: hintText, 
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h), 
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.r)
                  ),
                ),
                obscureText:obscurePresent! == true ? obscureEnabled : false ,
              ),
            ),
          )
        ],
      ),
    );
  }
}
