# Cartrack

## NOTE

This is a simple application where user can Login and land into the Listing screen. User can see the details and location on map by tapping on the item in the list.

As registration functionality is not in scope we have a hardcoded credentials for a user to login. Please use the following credentials to login.
Username: ABC123
Password: abc@123

With the given time constraints and the requirements in the task, there are some known issues/improvements that need to be addressed with some future scope in my wish. Please find them listed below:

### Known Issues/Imporvements
* Documentations need to be improved.
* Keyboard hides the Login button on Login screens.
* Currently the country has no use of it in the app even though the selection of country is mandatory and the authentication is done using User Name and Password as per requirement. So, according to my imagination, I would use the selected country to be displayed as the current country of the user on the Users Listing screen after login.
* Asynchronous loader to be added while the user is authenticated.
* Pagination is implemented in the User list screen with the loader on NavigationBar, but the user needs to see more eye-catching loader and bottom loader while loading more users after the user scrolls down.

### Future Improvement
* Add Registration functionality
* Enhance Network module
* Create reusable UI Components
* More appealing UI and Animation
* Improve scalability
* Increase UnitTests code coverage
* Implement Localization

### Requirements
* iOS 13.0+
* Swift 4+
* Xcode 12.4+

### Setup and Installation

Clone from git
```
git clone https://github.com/pranaydalal/Cartrack
```
Checkout main branch

### Running

Simply double tap on `Cartrack.xcodeproj`,  `cmd+r` and we are running.

### Running Tests
Simply `cmd+u`

### Code Folder Structure
* Cartrack
    * UI
        * Module
          * Views
          * ViewControllers
    * ViewModels
    * Utilities
    * Database
    * Networking
    * Models
    * Resources
 * CartrackTests
 * Products
 
