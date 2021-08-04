# Directory

iOS App developed for interview task

## Summary
* Runs on both iOS and iPadOS
* Tested on iPhone XR device ( as that's the only device I have got). But should work on all iOS and iPadOS devices

## GUI

* Directory list and Details - gives the look and feel on native contacts app to keep as as simple as possible from users' experience perspective.
* Search bar comes on swipe down of the list as standard. Currenlty allows searches by first and last name only. Can be extended to search by id etc.
* Contact Detail page show Tappable actions on Phone (SMS & Call), Email (Mailto:) and Location (Apple Maps)
* Rooms list - shows the available room with green blob icon and unavilable rooms with red. Shows the occupancy on the right using standard Right Details Cell.


## Test Coverage
* More tests to be added for full coverage as time permits. 
* Added test cases for core functionalties for API covering about 35% to give a gist.
* Havn't wrriten any UI tests yet due to time constraints.

## Code Resuabbility
* I have tried to keep the code base as reusable as possible. 
* API/ Service Calls are fully reusable
* EmployeeDetails should be fairly usable too


## Suggested improvements
* UI - Can add filter on Rooms list to get a filtered list of available rooms
* UI - search can be expanded to search by ID and other attributes
* UI - Save searches and show it as type suggestions on search
* Code - Further refactoring required to move few display logic to view models
