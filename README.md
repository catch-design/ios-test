# iOS Developer Test

A simple test for iOS Developers



## Instructions

1. Download or clone the solution.
2. Open the container folder and open CatchDesign.xcworkspace
3. Select simulator
4. Click the Run button or click on Product > Build to compile the project.

### Requirements
* Xcode 11 or higher.
* Simulator or real device with iOS 11 or higher

### Notes
I made the refresh control as a custom view, in the designs the activity indicator is not the system indicator. So with the custom view, It's easier to change it when I get the images from the designers.

For build the views I used mainly the Interface Builder, but also I created the background view programmatically using anchor constraints. 

The architecture that I used is MVP. I chose MVP because the unit test is a bonus item. With MVP or VIPER is the best way to test  the business logic because it is in the presenter. In the Unit test I create a presenter with a mock View and mock services.
Also I made the unit test of the service to check the correct behaviour of the network layer.

The project also includes UI Tests. For this I write all the encapsulate the components of each view into a view struct. That allows me to have clean and readable code when writing the tests.

I managed dependencies with CocoaPods. I used AlamoFire for the HTTP Connection and Firebase (Analytics and Crashlitycs) to log errors, handled exceptions and drop breadcrumbs.

For the font I used system font because this wasn’t presente in the designs (I couldn’t read that attribute from sketch)

Time: 8-10 hours.
