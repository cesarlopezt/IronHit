# IronHit: Workout tracker

IronHit is an iOS app built with SwiftUI and Core Data. It serves as a tool to manage your exercises, create workouts, and track your fitness progress. This readme file provides an overview of the app's features, functionality, and instructions for installation and usage.

[<img alt="Download_on_the_App_Store" src="https://github-production-user-asset-6210df.s3.amazonaws.com/4370350/237135478-4edfb044-ee21-4926-b67c-5830b7b0606c.svg">](https://apps.apple.com/us/app/ironhit-workout-tracker/id6448875839)

## Features
* **Exercise Management**: Add, edit, and delete exercises to build your personalized exercise library.
* **Tag Filtering**: Filter exercises based on tags to quickly find specific exercises.
* **Workout Creation**: Create workouts by selecting exercises from your library.
* **Workout Tracking**: Start and track your workouts, logging each exercise's sets, reps, and weights.
* **Workout History**: View a list of all previous workouts, including details and performance statistics.

## Data Model
![image](https://user-images.githubusercontent.com/4370350/236078385-8bc4093c-81f7-4cc2-8924-c9ee7ead084f.png)

## Walkthrough

### Exercises and Tags
https://user-images.githubusercontent.com/4370350/236081461-be1b3d28-44dd-4312-b718-d131f28e9775.mov


### Workouts and Workout Log
https://user-images.githubusercontent.com/4370350/236081790-25e44a5f-9da3-43eb-8ec4-5ae3dda3f676.mov

## Requirements
* iOS 16.0+

## Installation
1. Clone or download the IronHit repository from GitHub.
2. Open the project in Xcode.

## Dependencies
IronHit uses the following frameworks
* SwiftUI: SwiftUI is the modern declarative framework for building user interfaces across Apple platforms.
* CoreData: CoreData is used for local data persistence and managing the exercise and workout data.
Upon opening the project in Xcode, the dependencies will be automatically resolved and included.

## Usage
1. Launch the IronHit app on your iOS device or simulator.
2. On the home screen, you will see a list of exercises if any have been added previously.
3. To add a new exercise, tap on the "+" button at the top right corner and provide the necessary details: exercise name, description, tags.
4. To edit an existing exercise, click on the exercise and click on the pencil next to the trash can. Make the necessary modifications and tap "Save" to update the exercise.
5. To delete an exercise, click on the exercise and click on the trashcan and tap "Delete".
6. To filter exercises by tags, tap on the "Filter" button at the top right corner next to the plus icon. Select the desired tags to filter the exercises accordingly.
7. To create a workout, navigate to the "Workouts" tab and tap on the "+" button. Give the workout a name and add exercises from your exercise library specifying the sets and reps.
8. Once you have a workout created, you can start it by tapping on the workout item in the list and tapping on "Start Workout". This will take you to the workout tracking screen.
9. In the workout tracking screen, you can check the exercises of the workout like a To Do.
10. After completing a workout, you can view the list of all previous workouts in the "Calendar" tab filtered by days.
