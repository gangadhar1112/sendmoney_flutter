# SendMoney Flutter Application

# Introduction

- SendMoney is a Flutter-based application that enables users to send money securely and view their
  transaction history. It is built using Flutter with the Bloc state management pattern.

# Features

- Send money to users using their phone number.
- View transaction history with detailed information.
- Display wallet balance on the dashboard.
- Error handling and validation for input fields.
- Interactive UI with Material Design components.

# Tech Stack

- Flutter (Dart)
- Flutter Bloc (State Management)
- Firebase Firestore (Database)
- Intl (Date Formatting)

# Installation

1. Clone the repository:
    - git clone https://github.com/gangadhar1112/sendmoney_flutter.git
2. Install dependencies:
    - cd sendmoney_flutter

3. Install dependencies:
    - flutter pub get

4. Run the app:
    - flutter run

# Project Structure

lib/
|-- send_money/
| |-- bloc/
| | |-- send_money_bloc.dart
| | |-- send_money_event.dart
| | |-- send_money_state.dart
| |-- screen/
| | |-- send_money_screen.dart
|
|-- transaction_history/
| |-- bloc/
| | |-- transaction_bloc.dart
| | |-- transaction_events.dart
| | |-- transaction_state.dart
| |-- screen/
| | |-- transaction_screen.dart
|
|-- dashboard/
| |-- dashboard_screen.dart
| |-- dashboard_balance.dart

