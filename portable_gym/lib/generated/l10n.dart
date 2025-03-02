// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `go to Arabic`
  String get language {
    return Intl.message(
      'go to Arabic',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out ?`
  String get logOutMassage {
    return Intl.message(
      'Are you sure you want to log out ?',
      name: 'logOutMassage',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. `
  String get welcomeDescription {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `registration code field is empty`
  String get registrationCodeErrorMessage {
    return Intl.message(
      'registration code field is empty',
      name: 'registrationCodeErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `registration code is wrong`
  String get registrationCodeIsWrong {
    return Intl.message(
      'registration code is wrong',
      name: 'registrationCodeIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `sent email verification`
  String get emailVerificationMessage {
    return Intl.message(
      'sent email verification',
      name: 'emailVerificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `or sign up with`
  String get loginOtherOptions {
    return Intl.message(
      'or sign up with',
      name: 'loginOtherOptions',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? `
  String get loginSignUpOption {
    return Intl.message(
      'Don’t have an account? ',
      name: 'loginSignUpOption',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signUp {
    return Intl.message(
      'SignUp',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Let's start!`
  String get letsStart {
    return Intl.message(
      'Let\'s start!',
      name: 'letsStart',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// ` Confirm Password`
  String get confirmPassword {
    return Intl.message(
      ' Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgotten Password`
  String get forgottenPassword {
    return Intl.message(
      'Forgotten Password',
      name: 'forgottenPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Address`
  String get enterYourEmail {
    return Intl.message(
      'Enter Your Email Address',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `What’s Your Gender`
  String get whatsYourGender {
    return Intl.message(
      'What’s Your Gender',
      name: 'whatsYourGender',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continued {
    return Intl.message(
      'Continue',
      name: 'continued',
      desc: '',
      args: [],
    );
  }

  /// `How Old Are You?`
  String get howOldAreYou {
    return Intl.message(
      'How Old Are You?',
      name: 'howOldAreYou',
      desc: '',
      args: [],
    );
  }

  /// `What Is Your Weight?`
  String get whatsYourWeight {
    return Intl.message(
      'What Is Your Weight?',
      name: 'whatsYourWeight',
      desc: '',
      args: [],
    );
  }

  /// `What Is Your Height?`
  String get whatsYourHeight {
    return Intl.message(
      'What Is Your Height?',
      name: 'whatsYourHeight',
      desc: '',
      args: [],
    );
  }

  /// `KG`
  String get kg {
    return Intl.message(
      'KG',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `LB`
  String get lb {
    return Intl.message(
      'LB',
      name: 'lb',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Weight in KG`
  String get enterYourWeight {
    return Intl.message(
      'Enter Your Weight in KG',
      name: 'enterYourWeight',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Height in CM`
  String get enterYourHeight {
    return Intl.message(
      'Enter Your Height in CM',
      name: 'enterYourHeight',
      desc: '',
      args: [],
    );
  }

  /// `What Is Your Goal?`
  String get whatsYourGoal {
    return Intl.message(
      'What Is Your Goal?',
      name: 'whatsYourGoal',
      desc: '',
      args: [],
    );
  }

  /// `Weight Loss`
  String get weightLoss {
    return Intl.message(
      'Weight Loss',
      name: 'weightLoss',
      desc: '',
      args: [],
    );
  }

  /// `Weight Gain`
  String get weightGain {
    return Intl.message(
      'Weight Gain',
      name: 'weightGain',
      desc: '',
      args: [],
    );
  }

  /// `Muscles Mass Gain`
  String get musclesMassGain {
    return Intl.message(
      'Muscles Mass Gain',
      name: 'musclesMassGain',
      desc: '',
      args: [],
    );
  }

  /// `Shape body`
  String get shapeBody {
    return Intl.message(
      'Shape body',
      name: 'shapeBody',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Physical Activity Level`
  String get physicalActivityLevel {
    return Intl.message(
      'Physical Activity Level',
      name: 'physicalActivityLevel',
      desc: '',
      args: [],
    );
  }

  /// `Fill Your Profile`
  String get fillYourProfile {
    return Intl.message(
      'Fill Your Profile',
      name: 'fillYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get yearsOld {
    return Intl.message(
      'years old',
      name: 'yearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `the email field is empty!!`
  String get theEmailFieldIsEmpty {
    return Intl.message(
      'the email field is empty!!',
      name: 'theEmailFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `email field pattern is wrong`
  String get emailFieldPatternIsWrong {
    return Intl.message(
      'email field pattern is wrong',
      name: 'emailFieldPatternIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `the password field is empty!!`
  String get thePasswordFieldIsEmpty {
    return Intl.message(
      'the password field is empty!!',
      name: 'thePasswordFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `password should be at least 8 numbers or characters`
  String get passwordShouldBeAtLeast8NumbersOrCharacters {
    return Intl.message(
      'password should be at least 8 numbers or characters',
      name: 'passwordShouldBeAtLeast8NumbersOrCharacters',
      desc: '',
      args: [],
    );
  }

  /// `the full name field is empty!!`
  String get theFullNameFieldIsEmpty {
    return Intl.message(
      'the full name field is empty!!',
      name: 'theFullNameFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the nick name field is empty!!`
  String get theNickNameFieldIsEmpty {
    return Intl.message(
      'the nick name field is empty!!',
      name: 'theNickNameFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `full name field should not contain numbers`
  String get nameFieldShouldNotContainNumbers {
    return Intl.message(
      'full name field should not contain numbers',
      name: 'nameFieldShouldNotContainNumbers',
      desc: '',
      args: [],
    );
  }

  /// `confirm password is not equal to password!!`
  String get confirmPasswordIsNotEqualToPassword {
    return Intl.message(
      'confirm password is not equal to password!!',
      name: 'confirmPasswordIsNotEqualToPassword',
      desc: '',
      args: [],
    );
  }

  /// `you should choose profile photo`
  String get youShouldChooseProfilePhoto {
    return Intl.message(
      'you should choose profile photo',
      name: 'youShouldChooseProfilePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickName {
    return Intl.message(
      'Nickname',
      name: 'nickName',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `It's time to challenge your limits.`
  String get subTitle {
    return Intl.message(
      'It\'s time to challenge your limits.',
      name: 'subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get myProfile {
    return Intl.message(
      'Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change Meal Plan Questions`
  String get changeMealPlanQuestions {
    return Intl.message(
      'Change Meal Plan Questions',
      name: 'changeMealPlanQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Change Profile Questions`
  String get changeSetUpQuestions {
    return Intl.message(
      'Change Profile Questions',
      name: 'changeSetUpQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get questions {
    return Intl.message(
      'Questions',
      name: 'questions',
      desc: '',
      args: [],
    );
  }

  /// `Unlock The Locks`
  String get premium {
    return Intl.message(
      'Unlock The Locks',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get birthDate {
    return Intl.message(
      'Date of birth',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workOut {
    return Intl.message(
      'Workout',
      name: 'workOut',
      desc: '',
      args: [],
    );
  }

  /// `Progress tracking`
  String get progressTrack {
    return Intl.message(
      'Progress tracking',
      name: 'progressTrack',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message(
      'Nutrition',
      name: 'nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Ask Trainer`
  String get askTrainer {
    return Intl.message(
      'Ask Trainer',
      name: 'askTrainer',
      desc: '',
      args: [],
    );
  }

  /// `see all`
  String get seeAll {
    return Intl.message(
      'see all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Challenge`
  String get weeklyChallenge {
    return Intl.message(
      'Weekly Challenge',
      name: 'weeklyChallenge',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get beginner {
    return Intl.message(
      'Beginner',
      name: 'beginner',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get intermediate {
    return Intl.message(
      'Intermediate',
      name: 'intermediate',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `training of the day`
  String get trainingOfDay {
    return Intl.message(
      'training of the day',
      name: 'trainingOfDay',
      desc: '',
      args: [],
    );
  }

  /// `Round `
  String get round {
    return Intl.message(
      'Round ',
      name: 'round',
      desc: '',
      args: [],
    );
  }

  /// `repetition `
  String get reputation {
    return Intl.message(
      'repetition ',
      name: 'reputation',
      desc: '',
      args: [],
    );
  }

  /// `Rep`
  String get reputationShort {
    return Intl.message(
      'Rep',
      name: 'reputationShort',
      desc: '',
      args: [],
    );
  }

  /// `H`
  String get hour {
    return Intl.message(
      'H',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get minute {
    return Intl.message(
      'M',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `S`
  String get second {
    return Intl.message(
      'S',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `rest`
  String get rest {
    return Intl.message(
      'rest',
      name: 'rest',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishWord {
    return Intl.message(
      'English',
      name: 'englishWord',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabicWord {
    return Intl.message(
      'Arabic',
      name: 'arabicWord',
      desc: '',
      args: [],
    );
  }

  /// `Training Time`
  String get trainingTime {
    return Intl.message(
      'Training Time',
      name: 'trainingTime',
      desc: '',
      args: [],
    );
  }

  /// `PickVideo`
  String get pickVideo {
    return Intl.message(
      'PickVideo',
      name: 'pickVideo',
      desc: '',
      args: [],
    );
  }

  /// `Upload Training`
  String get uploadTraining {
    return Intl.message(
      'Upload Training',
      name: 'uploadTraining',
      desc: '',
      args: [],
    );
  }

  /// `Upload body category`
  String get uploadBodyCategory {
    return Intl.message(
      'Upload body category',
      name: 'uploadBodyCategory',
      desc: '',
      args: [],
    );
  }

  /// `edit body category`
  String get editBodyCategory {
    return Intl.message(
      'edit body category',
      name: 'editBodyCategory',
      desc: '',
      args: [],
    );
  }

  /// `add body category`
  String get addBodyCategory {
    return Intl.message(
      'add body category',
      name: 'addBodyCategory',
      desc: '',
      args: [],
    );
  }

  /// `add new training`
  String get addNewTraining {
    return Intl.message(
      'add new training',
      name: 'addNewTraining',
      desc: '',
      args: [],
    );
  }

  /// `edit training`
  String get editTraining {
    return Intl.message(
      'edit training',
      name: 'editTraining',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minuteWord {
    return Intl.message(
      'minute',
      name: 'minuteWord',
      desc: '',
      args: [],
    );
  }

  /// `KCal`
  String get kCal {
    return Intl.message(
      'KCal',
      name: 'kCal',
      desc: '',
      args: [],
    );
  }

  /// `KCal/100Gm`
  String get kCalPerGram {
    return Intl.message(
      'KCal/100Gm',
      name: 'kCalPerGram',
      desc: '',
      args: [],
    );
  }

  /// `exercises`
  String get exercises {
    return Intl.message(
      'exercises',
      name: 'exercises',
      desc: '',
      args: [],
    );
  }

  /// `Let's go `
  String get letsGo {
    return Intl.message(
      'Let\'s go ',
      name: 'letsGo',
      desc: '',
      args: [],
    );
  }

  /// `Explore Different Workout Styles`
  String get exploreDifferentWorkoutStyles {
    return Intl.message(
      'Explore Different Workout Styles',
      name: 'exploreDifferentWorkoutStyles',
      desc: '',
      args: [],
    );
  }

  /// `meal plan`
  String get mealPlan {
    return Intl.message(
      'meal plan',
      name: 'mealPlan',
      desc: '',
      args: [],
    );
  }

  /// `meal idea`
  String get mealIdea {
    return Intl.message(
      'meal idea',
      name: 'mealIdea',
      desc: '',
      args: [],
    );
  }

  /// `recipe of the day`
  String get recipeOfDay {
    return Intl.message(
      'recipe of the day',
      name: 'recipeOfDay',
      desc: '',
      args: [],
    );
  }

  /// `BreakFast`
  String get breakfast {
    return Intl.message(
      'BreakFast',
      name: 'breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Lunch`
  String get lunch {
    return Intl.message(
      'Lunch',
      name: 'lunch',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get dinner {
    return Intl.message(
      'Dinner',
      name: 'dinner',
      desc: '',
      args: [],
    );
  }

  /// `Snacks`
  String get snacks {
    return Intl.message(
      'Snacks',
      name: 'snacks',
      desc: '',
      args: [],
    );
  }

  /// `Recipe`
  String get recipe {
    return Intl.message(
      'Recipe',
      name: 'recipe',
      desc: '',
      args: [],
    );
  }

  /// `Add Recipe`
  String get addRecipe {
    return Intl.message(
      'Add Recipe',
      name: 'addRecipe',
      desc: '',
      args: [],
    );
  }

  /// `Edit Recipe`
  String get editRecipe {
    return Intl.message(
      'Edit Recipe',
      name: 'editRecipe',
      desc: '',
      args: [],
    );
  }

  /// `protein`
  String get protein {
    return Intl.message(
      'protein',
      name: 'protein',
      desc: '',
      args: [],
    );
  }

  /// `carbohydrate`
  String get carbohydrate {
    return Intl.message(
      'carbohydrate',
      name: 'carbohydrate',
      desc: '',
      args: [],
    );
  }

  /// `Advantage`
  String get advantage {
    return Intl.message(
      'Advantage',
      name: 'advantage',
      desc: '',
      args: [],
    );
  }

  /// `ask your owen meal plan`
  String get createMealPlanMassage {
    return Intl.message(
      'ask your owen meal plan',
      name: 'createMealPlanMassage',
      desc: '',
      args: [],
    );
  }

  /// `food main element`
  String get foodMainElement {
    return Intl.message(
      'food main element',
      name: 'foodMainElement',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Workout Log`
  String get workoutLog {
    return Intl.message(
      'Workout Log',
      name: 'workoutLog',
      desc: '',
      args: [],
    );
  }

  /// `Charts`
  String get charts {
    return Intl.message(
      'Charts',
      name: 'charts',
      desc: '',
      args: [],
    );
  }

  /// `Choose Date`
  String get chooseDate {
    return Intl.message(
      'Choose Date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activities {
    return Intl.message(
      'Activity',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `your request has been sent\nplease wait till the couch create your plan`
  String get createRequestSuccessMessage {
    return Intl.message(
      'your request has been sent\nplease wait till the couch create your plan',
      name: 'createRequestSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `sorry, but you should solve all questions`
  String get mealPlanRequestsErrorMassage {
    return Intl.message(
      'sorry, but you should solve all questions',
      name: 'mealPlanRequestsErrorMassage',
      desc: '',
      args: [],
    );
  }

  /// `type your message`
  String get hintMessage {
    return Intl.message(
      'type your message',
      name: 'hintMessage',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message(
      'File',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `you should choose file first`
  String get sendFileErrorMessage {
    return Intl.message(
      'you should choose file first',
      name: 'sendFileErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Delete Item`
  String get alertDeleteTitle {
    return Intl.message(
      'Delete Item',
      name: 'alertDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get alertDeleteContent {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'alertDeleteContent',
      desc: '',
      args: [],
    );
  }

  /// `admin`
  String get admin {
    return Intl.message(
      'admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Registration Code`
  String get registrationCode {
    return Intl.message(
      'Registration Code',
      name: 'registrationCode',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get subscriptiosWord {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptiosWord',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date: `
  String get expireDate {
    return Intl.message(
      'Expire Date: ',
      name: 'expireDate',
      desc: '',
      args: [],
    );
  }

  /// `the english name field is empty`
  String get englishNameFieldIsEmpty {
    return Intl.message(
      'the english name field is empty',
      name: 'englishNameFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic name field is empty`
  String get arabicNameFieldIsEmpty {
    return Intl.message(
      'the arabic name field is empty',
      name: 'arabicNameFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english calories field is empty`
  String get englishCaloriesFieldIsEmpty {
    return Intl.message(
      'the english calories field is empty',
      name: 'englishCaloriesFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic calories field is empty`
  String get arabicCaloriesFieldIsEmpty {
    return Intl.message(
      'the arabic calories field is empty',
      name: 'arabicCaloriesFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english protein field is empty`
  String get englishProteinFieldIsEmpty {
    return Intl.message(
      'the english protein field is empty',
      name: 'englishProteinFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic protein field is empty`
  String get arabicProteinFieldIsEmpty {
    return Intl.message(
      'the arabic protein field is empty',
      name: 'arabicProteinFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english carbohydrates field is empty`
  String get englishCarbohydratesFieldIsEmpty {
    return Intl.message(
      'the english carbohydrates field is empty',
      name: 'englishCarbohydratesFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic carbohydrates field is empty`
  String get arabicCarbohydratesFieldIsEmpty {
    return Intl.message(
      'the arabic carbohydrates field is empty',
      name: 'arabicCarbohydratesFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english advantage field is empty`
  String get englishAdvantageFieldIsEmpty {
    return Intl.message(
      'the english advantage field is empty',
      name: 'englishAdvantageFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic advantage field is empty`
  String get arabicAdvantageFieldIsEmpty {
    return Intl.message(
      'the arabic advantage field is empty',
      name: 'arabicAdvantageFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the image link field is empty`
  String get imageLinkFieldIsEmpty {
    return Intl.message(
      'the image link field is empty',
      name: 'imageLinkFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `you should choose at least on type of meal`
  String get mealTypeOptionsAreEmpty {
    return Intl.message(
      'you should choose at least on type of meal',
      name: 'mealTypeOptionsAreEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english number of reputation field is empty`
  String get englishNumberReputationFieldIsEmpty {
    return Intl.message(
      'the english number of reputation field is empty',
      name: 'englishNumberReputationFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic number of reputation field is empty`
  String get arabicNumberReputationFieldIsEmpty {
    return Intl.message(
      'the arabic number of reputation field is empty',
      name: 'arabicNumberReputationFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english number of round field is empty`
  String get englishNumberRoundFieldIsEmpty {
    return Intl.message(
      'the english number of round field is empty',
      name: 'englishNumberRoundFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic number of round field is empty`
  String get arabicNumberRoundFieldIsEmpty {
    return Intl.message(
      'the arabic number of round field is empty',
      name: 'arabicNumberRoundFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english instruction field is empty`
  String get englishInstructionFieldIsEmpty {
    return Intl.message(
      'the english instruction field is empty',
      name: 'englishInstructionFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic instruction field is empty`
  String get arabicInstructionFieldIsEmpty {
    return Intl.message(
      'the arabic instruction field is empty',
      name: 'arabicInstructionFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the video link field is empty`
  String get videoLinkFieldIsEmpty {
    return Intl.message(
      'the video link field is empty',
      name: 'videoLinkFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english title field is empty`
  String get englishTitleFieldIsEmpty {
    return Intl.message(
      'the english title field is empty',
      name: 'englishTitleFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the english number of exercises field is empty`
  String get englishNumberOfExercisesFieldIsEmpty {
    return Intl.message(
      'the english number of exercises field is empty',
      name: 'englishNumberOfExercisesFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic title field is empty`
  String get arabicTitleFieldIsEmpty {
    return Intl.message(
      'the arabic title field is empty',
      name: 'arabicTitleFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the arabic number of exercises field is empty`
  String get arabicNumberOfExercisesIsEmpty {
    return Intl.message(
      'the arabic number of exercises field is empty',
      name: 'arabicNumberOfExercisesIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `the total time is not set`
  String get totalTimeIsNotSet {
    return Intl.message(
      'the total time is not set',
      name: 'totalTimeIsNotSet',
      desc: '',
      args: [],
    );
  }

  /// `category has been deleted`
  String get categoryHasBeenDeleted {
    return Intl.message(
      'category has been deleted',
      name: 'categoryHasBeenDeleted',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
