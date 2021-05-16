function checkValidation(mobileValue , emailValue , nameValue , genderValue , passwordValue , ConfirmPasswordValue) {

    var check_MobileNumber;
    var check_Email;
    var check_Name;
    var check_Gender;
    var check_Password;

    //print("in JS FILE : " , mobileValue , "  " , emailValue , "  " , nameValue , "  " , genderValue , "  " , passwordValue , "  " , ConfirmPasswordValue)

    function validateEmail(mail)
    {
        var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (re.test(mail))
        {
//            log("VALID")
            return true;
        }
//        log("inVALID")
        return false;

    }

    //-- Check Mobile Number --//
    if(mobileValue.length < 11){
//        log("Mobile not Completed")
        check_MobileNumber = false;
        return false;
    }
    else{
//        log("Mobile Passed")
        check_MobileNumber = true;
    }

    //-- Check EMail --//
    if(validateEmail(emailValue)){
        check_Email = true
//        log("EMail Passed")
    }else{
//        log("Email is Wrong")
        check_Email = false
        return false;
    }

    //-- Check Name --//
    if(nameValue.length > 0){
        check_Name = true
//        log("Name Passed")
    }else{
        check_Name = false
//        log("Name is Empty")
        return false;
    }

    //-- Check Name --//
    if(genderValue.length > 0){
        check_Gender = true
//        log("Gender Passed")
    }else{
        check_Gender = false
//        log("Gender is Empty")
        return false;
    }

    //-- Check Password --//
    if(passwordValue === ConfirmPasswordValue){
        var a = RegExp(/^(?=.*\d)(?=.*[a-z]).{8,16}$/) // this RegExp Means => password most have character and number
        print("A.TEST = " , a.test(passwordValue))
        if(a.test(passwordValue)){
            check_Password = true
//            print("1 : " , check_MobileNumber + "  " + check_Email + "  " + check_Gender + "  " + check_Name + "  " + check_Password)
            return true;
        }
        else{
            check_Password = false
//            print("2 : " , check_MobileNumber + "  " + check_Email + "  " + check_Gender + "  " + check_Name + "  " + check_Password)
            return false;
        }

    }else{
        check_Password = false
//        print("3 : " , check_MobileNumber + "  " + check_Email + "  " + check_Gender + "  " + check_Name + "  " + check_Password)
        return false;
    }


}

//-- EMAIL --//
function validateEmail(mail){

    var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (re.test(mail))
    {
//        log("VALID")
        return true;
    }
//    log("inVALID")
    return false;

}

//-- MOBILE --//
function validateMobile(mobileValue){
    if(mobileValue.length < 11){
        return false;
    }
    else{
        return true
    }
}

//-- NAME --//
function validateName(nameValue){
    if(nameValue.length > 0){
        return true;
    }else{
        return false;
    }
}

//-- GENDER --//
function validateGender(genderValue){
    if(genderValue.length > 0){
        return true;
    }else{
        return false;
    }
}

//-- PASSWORD --//
function validatePassword(passwordValue , ConfirmPasswordValue){

        if(passwordValue === ConfirmPasswordValue){
            var a = RegExp(/^(?=.*\d)((?=.*[a-z])*|(?=.*[A-Z])).{8,16}$/)
            if(a.test(passwordValue)){
                return true;
            }
            else{
                return false;
            }

        }else{
            return false;
        }
}





