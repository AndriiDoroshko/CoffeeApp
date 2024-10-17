## Flutter Project: coffee_app

This Flutter project is designed for users who love coffee and want to find inspiration for new coffee creations. The app has two main tabs: 

**Inspiration Tab**
* Users can load random images of coffee from a public API. 
* They can save images they like locally. 
* They can also delete saved images.

**Favorites Tab**
* Users can view a grid of all their locally saved coffee images.

The app utilizes BLoC pattern for state management, providing a responsive and user-friendly experience. The project includes standard configurations for Android, iOS, Linux, macOS, web and Windows platforms.

## How to Run CoffeeApp

### Prerequisites

Make sure you have the following installed on your machine before running the app:

- **Flutter SDK**: Follow the [official guide](https://docs.flutter.dev/get-started/install) to install Flutter on your system.
- **Xcode** (for iOS development): Ensure Xcode is installed and properly set up if you are developing for iOS.
- **Android Studio** (for Android development): Make sure Android Studio is installed, along with the necessary Android SDK and emulator setup.

### Steps to Run the App

1. **Clone the Repository**:
    Open your terminal and clone the repository:
    ```bash
    git clone https://github.com/AndriiDoroshko/CoffeeApp.git
    ```

2. **Navigate to the Project Directory:
    Go to the root of the project: 
    ```bash
    cd CoffeeApp
    ```

3. **Install Dependencies: 
    Run the following command to install all required packages:
    ```bash
    flutter pub get
    ```

4. **Run the App:
    ```bash
    flutter run
    ```

### Inputs

* **Inspiration Tab:**
    * User interaction with "Load New" button to fetch a new random coffee image.
    * User interaction with "Save" or "Remove" button to save or delete the displayed image.

### Outputs

* **Inspiration Tab:**
    * Display of a random coffee image fetched from the API.
    * Success or error dialogs for saving and deleting images.

* **Favorites Tab:**
    * A grid view displaying all the locally saved coffee images.