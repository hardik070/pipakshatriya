import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'datamodels/user_model.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'datamodels/login_info.dart';



class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({super.key});

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}
class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  bool showPassword = true;
  bool isSignInMode = true;
  bool forgetPassword = false;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail(ScaffoldMessengerState messenger, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Password reset email sent to $email',
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  Future<void> userAuthSignIn(ScaffoldMessengerState messenger) async{
    String email = emailController.text;
    String password = passwordController.text;


    try{
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      String userId = email.replaceAll('@gmail.com', '').replaceAll('.', '_');
      await fatchDataFirestore(userId);
      setState(() {
        isLoading = false;
      });
    }catch (e){
      messenger.showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text("$e",style: TextStyle(fontSize: 15),),
            duration: Duration(milliseconds: 1000),
          )
      );
      setState(() {
        isLoading = false;
      });
      return ;
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard()
      )
    );
  }

  Future<void> fatchDataFirestore(String userId) async{
    final snapshot = await _ref.collection('users').doc(userId).get();
    final data = snapshot.data();
    if(data != null) {
      final user = UserModel(
          name: data['name'] ?? '',
          profilePic: data['profilePic'] ?? '',
          fatherName: data['fatherName'] ?? '',
          email: data['email'] ?? '',
          phoneNumber: List<String>.from(data['numbers'] ?? []),
          gotra: data['gotra'] ?? '',
          actualAddress: data['actualAddress'] ?? '',
          relationships: List<Map<String, String>>.from(
            (data['relations'] ?? []).map((e) => Map<String, String>.from(e)),
          ),
          loginInfo: LoginInfo(
              token: data['userId'] ?? '', loginTime: DateTime.now()),
          contacts: [],
          currentAddress: data['currentAddress'] ?? '',
          userId: data['userId'] ?? ''
      );
      await UserDataManager().updateUser(user);
    }
  }

  Future<void> createUserSignUp() async{
    String email = emailController.text;
    String password = passwordController.text;
    String name = userNameController.text.trim();

    try{
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
     await storeFirestoreAccountCreation(email, name);
    }catch (e){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text("$e",style: TextStyle(fontSize: 15),),
            duration: Duration(milliseconds: 1000),
          )
      );
      setState(() {
        isLoading = false;
      });
      return ;
    }

    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard()
      )
    );
  }

  Future<void> storeFirestoreAccountCreation(String email, String name) async{
    final String userId = email.replaceAll('@gmail.com', '').replaceAll('.', '_');

    try{
      await _ref.collection('users').doc(userId).set({
        'name' : name,
        'email' : email,
        'userId' : userId,
        'createdAt' : FieldValue.serverTimestamp()
      });

     await storeHiveAccountCreation(email, name, userId);
    }catch (e){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text("$e",style: TextStyle(fontSize: 15),),
            duration: Duration(milliseconds: 1000),
          )
      );
    }
  }

  Future<void> storeHiveAccountCreation(String email, String name, String userId) async{

    try{
      final user = UserModel(
          name: name,
          profilePic: '',
          fatherName: '',
          email: email,
          phoneNumber: [],
          gotra: '',
          actualAddress: '',
          relationships: [],
          loginInfo: LoginInfo(token: userId, loginTime: DateTime.now()),
          contacts: [],
          currentAddress: '',
          userId: userId
      );

      await UserDataManager().updateUser(user);
    }catch (e){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text("$e",style: TextStyle(fontSize: 15),),
            duration: Duration(milliseconds: 1000),
          )
      );
    }
  }


  @override
  void dispose() {
    // Dispose the TextEditingController to free up resources
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        //body: Expanded(
          body: Container(
            //width: 100,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                stops: [0, 1],
                begin: AlignmentDirectional(0.87, -1),
                end: AlignmentDirectional(-0.87, 1),
              ),
            ),
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Pipa Kshartriya',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  forgetPassword ? ForgetPassword(context) : (isSignInMode ? signIn(context) : signUp(context)),
                  //SignInScreen()
                ],
              ),
            ),
          ),
        //),
      ),
    );
  }

  Widget signIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 570),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF101213),
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'To get into your account please enter email and password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF1F4F8),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF1F4F8), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4B39EF), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF1F4F8),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF57636C),
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 35),
              isLoading ? CircularProgressIndicator() : ElevatedButton(
                onPressed: () {
                  userAuthSignIn(ScaffoldMessenger.of(context));
                  setState(() {
                    isLoading = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF),
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      forgetPassword = !forgetPassword;
                    });
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              InkWell(
                onTap: () {
                  setState(() {
                    isSignInMode = !isSignInMode;
                  });
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up here',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF4B39EF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ForgetPassword(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 570),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Forget Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF101213),
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'To reset your password enter your email address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF1F4F8),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              isLoading ? CircularProgressIndicator() : ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isNotEmpty) {
                    sendPasswordResetEmail(ScaffoldMessenger.of(context), email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter your email.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF),
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Send link',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 30),

              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    forgetPassword = !forgetPassword;
                  });
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Go to ',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF4B39EF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 570),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF101213),
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Let's get started by filling out the form below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF1F4F8), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4B39EF), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF1F4F8),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF1F4F8), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4B39EF), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF1F4F8),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF57636C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF1F4F8), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4B39EF), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF1F4F8),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF57636C),
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 35),
              isLoading ? CircularProgressIndicator() : ElevatedButton(
                onPressed: () {
                  if(emailController.text.contains("@gmail.com")) {
                    if(passwordController.text.length >= 8) {
                      if(!passwordController.text.contains(' ')){
                        createUserSignUp();
                        setState(() {
                          isLoading = true;
                        });
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.deepPurpleAccent,
                              content: Text("Invalid password, remove blank spaces",style: TextStyle(fontSize: 15),),
                              duration: Duration(milliseconds: 1000),
                            )
                        );
                      }
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.deepPurpleAccent,
                            content: Text(
                              "Password length should be 8 Character",
                              style: TextStyle(fontSize: 15),),
                            duration: Duration(milliseconds: 1000),
                          )
                      );
                    }
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.deepPurpleAccent,
                          content: Text(
                            "Please enter valid email", style: TextStyle(
                              fontSize: 15),),
                          duration: Duration(milliseconds: 1000),
                        )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B39EF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 44),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Text(
              //   'Or sign up with',
              //   style: TextStyle(
              //     fontFamily: 'Plus Jakarta Sans',
              //     color: Color(0xFF57636C),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // SizedBox(height: 16),
              // OutlinedButton.icon(
              //   onPressed: () {
              //     // Handle Google sign-up
              //   },
              //   style: OutlinedButton.styleFrom(
              //     side: BorderSide(color: Color(0xFFE0E3E7), width: 2),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     minimumSize: Size(double.infinity, 44),
              //   ),
              //   icon: Icon(Icons.account_circle, color: Color(0xFF57636C)),
              //   label: Text(
              //     'Continue with Google',
              //     style: TextStyle(
              //       color: Color(0xFF101213),
              //       fontSize: 16,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSignInMode = !isSignInMode;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFF101213),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Color(0xFF4B39EF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

