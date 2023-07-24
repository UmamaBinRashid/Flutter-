import 'dart:io';

List<Map<String, dynamic>> passengers = [];
List<String> loginHistory = [];
bool loggedIn = false;

void addPassenger() {
  if (!loggedIn) {
    print('You must log in first.');
    return;
  }
  print('Enter passenger details:');
  stdout.write('Name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Address: ');
  String address = stdin.readLineSync()!;

  stdout.write('Phone Number: ');
  String phoneNumber = stdin.readLineSync()!;

  Map<String, dynamic> newPassenger = {
    'name': name,
    'address': address,
    'phoneNumber': phoneNumber,
    'history': [],
  };
  passengers.add(newPassenger);
  print('Passenger added successfully!');
}

void updatePassenger() {
  if (passengers.isEmpty) {
    print('No passengers found.');
    return;
  }

  stdout.write('Enter passenger number to update: ');
  int passengerNumber = int.parse(stdin.readLineSync()!) - 1;

  if (passengerNumber < 0 || passengerNumber >= passengers.length) {
    print('Invalid passenger number.');
    return;
  }

  Map<String, dynamic> passenger = passengers[passengerNumber];

  stdout.write('New Name: ');
  String name = stdin.readLineSync()!;
  if (name.isNotEmpty) {
    passenger['name'] = name;
  }

  stdout.write('New Address: ');
  String address = stdin.readLineSync()!;
  if (address.isNotEmpty) {
    passenger['address'] = address;
  }

  stdout.write('New Phone Number: ');
  String phoneNumber = stdin.readLineSync()!;
  if (phoneNumber.isNotEmpty) {
    passenger['phoneNumber'] = phoneNumber;
  }

  print('Passenger updated successfully!');
}

void viewPassengers() {
  if (passengers.isEmpty) {
    print('No passengers found.');
    return;
  }

  print('List of Passengers:');
  for (int i = 0; i < passengers.length; i++) {
    Map<String, dynamic> passenger = passengers[i];
    print('Passenger ${i + 1}:');
    print('Name: ${passenger['name']}');
    print('Address: ${passenger['address']}');
    print('Phone Number: ${passenger['phoneNumber']}');
    print('-------------------');
  }
}

void deletePassenger() {
  if (passengers.isEmpty) {
    print('No passengers found.');
    return;
  }

  stdout.write('Enter passenger number to delete: ');
  int passengerNumber = int.parse(stdin.readLineSync()!) - 1;

  if (passengerNumber < 0 || passengerNumber >= passengers.length) {
    print('Invalid passenger number.');
    return;
  }

  passengers.removeAt(passengerNumber);
  print('Passenger deleted successfully!');
}

void login() {
  stdout.write('Enter username: ');
  String username = stdin.readLineSync()!;

  stdout.write('Enter password: ');
  String password = stdin.readLineSync()!;

  // Perform authentication logic here
  // For simplicity, let's assume successful authentication
  print('Login successful!');

  loginHistory.add('Logged in at ${DateTime.now()}');
  loggedIn = true;
}

void logout() {
  print('Logged out successfully!');

  loginHistory.add('Logged out at ${DateTime.now()}');
  loggedIn = false;
}

void displayLoginHistory() {
  if (loginHistory.isEmpty) {
    print('No login history found.');
    return;
  }

  print('Login History:');
  for (int i = 0; i < loginHistory.length; i++) {
    print('${i + 1}. ${loginHistory[i]}');
  }
}

void viewPassengerHistory() {
  if (!loggedIn) {
    print('You must log in first.');
    return;
  }

  if (passengers.isEmpty) {
    print('No passengers found.');
    return;
  }

  stdout.write('Enter passenger number to display history: ');
  int passengerNumber = int.parse(stdin.readLineSync()!) - 1;

  if (passengerNumber < 0 || passengerNumber >= passengers.length) {
    print('Invalid passenger number.');
    return;
  }

  Map<String, dynamic> passenger = passengers[passengerNumber];

  List<String> history = passenger['history'];
  print('Passenger History:');
  if (history.isEmpty) {
    print('No history found for this passenger.');
  } else {
    for (int i = 0; i < history.length; i++) {
      print('${i + 1}. ${history[i]}');
    }
  }
}

void main() {
  while (true) {
    print('Airline Reservation System');
    print('1. Login');
    print('2. Add Passenger');
    print('3. Update Passenger');
    print('4. View Passengers');
    print('5. Delete Passenger');
    print('6. Logout');
    print('7. Login History');
    print('8. View Passenger History');
    print('9. Exit');
    stdout.write('Enter your choice: ');
    String choice = stdin.readLineSync()!;

    switch (choice) {
      case '1':
        if (!loggedIn) {
          login();
        } else {
          print('You are already logged in.');
        }
        break;
      case '2':
        addPassenger();
        break;
      case '3':
        if (loggedIn) {
          updatePassenger();
        } else {
          print('You must log in first.');
        }
        break;
      case '4':
        viewPassengers();
        break;
      case '5':
        if (loggedIn) {
          deletePassenger();
        } else {
          print('You must log in first.');
        }
        break;
      case '6':
        if (loggedIn) {
          logout();
        } else {
          print('You are not logged in.');
        }
        break;
      case '7':
        displayLoginHistory();
        break;
      case '8':
        viewPassengerHistory();
        break;
      case '9':
        print('Exiting...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }

    print('\n');
  }
}