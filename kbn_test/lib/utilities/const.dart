import 'package:kbn_test/service/apiServices.dart';

const firmName = "KERALA BUSINESS NETWORK";
const logoName = '''KERALA
BUSINESS
NETWORK''';
const welcomeComp = "Welcome Back Companies";
const welcome = "Welcome Back ";

const useMail = "continue with email";
const forget = "forget password?";
const frgtpswd = "Forget Password";
const noacc = "Don't you have an account?";
const tac =
    '''*The portal may update its terms and conditions, and continued use of the 
service indicates acceptance of any changes.*''';
const terms = "accept all terms & conditions";
const hi = "Hi,";
const signup = "SIGN UP";
const signin = "Sign In";
const logout = "Logout";
const backtohome = "Back to home";
const doYoyWantLogout = "Do you want to logout?";
const cardcontent =
    "content fromm api[HBC Web-World, a fast-growing IT company, is seeking a skilled Full Stack Developer to join our innovative team. The ideal candidate will . . . . . .]";
const forgetpswd =
    "No worries! Just enter your email address, and reset your password.";
const findJob = "Find job";
const info = "Information";
const updatepswd = "Password updated successfully";
const profile = "Profile";
const name = "KERALA BUSINESS NETWORK";
const tachead = "Terms & Conditions";
const newjob = "Let's Find You A New Job";
const latestjob = "Latest jobs";
const currentMonth = "Current month";
const previousMonth = "Previous month";
const profileSum =
    'I am a passionate and results-driven Product Manager with a deep commitment to creating innovative products that meet customer needs and drive business success. With 6 years of experience in the tech industry, I have a proven track record of managing the entire product lifecycle—from ideation to launch and beyond.';
const respon =
    "Product Strategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performancerategy and Vision Market Research and Analysis Product Development Stakeholder Management Performance Monitoring and Optimization";
const upimg = "Upload your image";
const summry =
    "We are seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. There seeking a highly skilled and experienced Product Manager to join our dynamic team. The ideal candidate will be responsible for overseeing the entire product lifecycle, from ideation and strategy to launch and optimization. This role requires a blend of business acumen, technical knowledge, and a customer-focused mindset to drive the success of our products.";

const aboutcomp =
    "LUMA Solutions, a leading IT company, is seeking an experienced Product Manager to lead the development and execution of innovative technology products. The ideal candidate will have a strong background in product lifecycle management, from ideation to launch, with a deep understanding of market trends and user needs. Responsibilities include defining product vision, collaborating with cross-functional teams, and driving the roadmap to achieve business goals. If you have a passion for technology and a track record of delivering successful products, we'd love to hear from you.";
const T_n_C_user =
    '''1. Account Responsibilities : Users must provide accurate information and maintain account security. Misuse may result in
suspension or termination.

2. Permitted Use : The portal is for job searching and related activities only. Inappropriate use, such as spamming or false 
job postings, is prohibited.

3. Privacy and Data : Personal data is collected and used in accordance with the privacy policy. Users consent to data being
shared with potential employers. 

4. Job Listings : The portal does not guarantee the accuracy of job postings. Users should verify job details independently.

5. Intellectual Property : Content on the portal is protected by intellectual property laws. Unauthorized copying or 
redistribution is not allowed. 

6. Liability : The portal is not responsible for job application outcomes or any damages resulting from the use of the site. 

7. Termination : Accounts may be suspended or terminated for violations of the terms. 

8. Updates : The portal may update these terms, and continued use implies acceptance of the new terms.''';

final T_n_C_company = '''
Welcome to ${userDetails['user']['name']}. By accessing and using our services, you agree to the following terms and conditions:

1.  Acceptance of Terms: By using our website or services, you agree to comply with and be bound by these terms and
    conditions. If you do not agree, please do not use our services. 
2.  Use of Services: Our services are intended for lawful purposes only. You agree not to misuse our services, including 
    engaging in any activity that could harm our systems, other users, or third parties.
3.  User Account: You are responsible for maintaining the confidentiality of your account information and for all activities that
    occur under your account. Notify us immediately of any unauthorized use of your account.
4.  Intellectual Property: All content on our website, including text, graphics, logos, and software, is the property of ${userDetails['user']['name']} or its licensors and is protected by intellectual property laws. You may not use, reproduce, or distribute 
    any content without our express permission.
5   Privacy Policy: Your use of our services is also governed by our Privacy Policy, which outlines how we collect, use, and 
    protect your personal information.
6.  Limitation of Liability: ${userDetails['user']['name']} is not liable for any direct, indirect, incidental, or consequential damages 
    arising from your use of our services. We provide our services "as is" without warranties of any kind.
7.  Termination: We reserve the right to terminate or suspend your access to our services at any time, with or without notice, 
    if you violate these terms.
8.  Changes to Terms: We may update these terms and conditions from time to time. Continued use of our services after any 
    changes indicates your acceptance of the new terms.
9.  Contact Information: If you have any questions about these terms and conditions, please contact us at ${userDetails['user']['contact']}.''';

const T_n_C_admin =
    ''' Welcome to KBN ( Kerala Business Network ) . By accessing and using our services, you agree to the following terms and conditions:
Acceptance of Terms: By using our website or services, you agree to comply with and be bound by these terms and conditions. If you do not agree, please do not use our services.
Use of Services: Our services are intended for lawful purposes only. You agree not to misuse our services, including engaging in any activity that could harm our systems, other users, or third parties.
User Account: You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. Notify us immediately of any unauthorized use of your account.
Intellectual Property: All content on our website, including text, graphics, logos, and software, is the property of [Your Company Name] or its licensors and is protected by intellectual property laws. You may not use, reproduce, or distribute any content without our express permission.
Privacy Policy: Your use of our services is also governed by our Privacy Policy, which outlines how we collect, use, and protect your personal information.
Limitation of Liability: KBN is not liable for any direct, indirect, incidental, or consequential damages arising from your use of our services. We provide our services "as is" without warranties of any kind.
Termination: We reserve the right to terminate or suspend your access to our services at any time, with or without notice, if you violate these terms.
Changes to Terms: We may update these terms and conditions from time to time. Continued use of our services after any changes indicates your acceptance of the new terms.
Contact Information: If you have any questions about these terms and conditions, please contact us at [Your Contact Information].''';
//.................................................................


const kbnAddress =  '''Smruthy Towers
183/C, HMT Junction,
Kalamassery, Kochi''';
const kbnNum = "+91 8848876965";
const kbnSite ="https://kbn-official.com/";
const managerName = 'Manager Name';
const managerMail = 'Manager Email';
const addAddress ="Address: Add Address";
const addWebsite = "Website: Add Company Website";