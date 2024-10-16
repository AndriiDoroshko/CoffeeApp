## Flutter Project: coffee_app

This Flutter project is designed for users who love coffee and want to find inspiration for new coffee creations. The app has two main tabs: 

**Inspiration Tab**
* Users can load random images of coffee from a public API. 
* They can save images they like locally. 
* They can also delete saved images.

**Favorites Tab**
* Users can view a grid of all their locally saved coffee images.

The app utilizes BLoC pattern for state management, providing a responsive and user-friendly experience. The project includes standard configurations for Android, iOS, Linux, macOS, web and Windows platforms.

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