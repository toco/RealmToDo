# RealmToDo

A small application originally developed by [Piet Brauer](https://github.com/pietbrauer/RealmToDo) to demonstrate Realm and Swift at Hamburg CocoaHeads.

I used it at Hamburg CocoaHeads as a demo project in my talk about automate screenshots.
Slides are [here](https://speakerdeck.com/toco/automated-screenshots-on-ios).

You can follow the process in these steps:

## [Step 0](https://github.com/toco/RealmToDo/commit/733ae11c68fa845d1986b68ade195655e894cdab)
Prepare project

## [Step 1](https://github.com/toco/RealmToDo/commit/65a84a891a066dad85899631a42ffcb982ca73f6)
Automate the UI flow using [KIF](https://github.com/kif-framework/KIF/)

## [Step 2](https://github.com/toco/RealmToDo/commit/ed9b81eaa5815f0d7afa6ca84c6fd98b45ce8da0)
Add code to actually take screenshots using [TOCScreenshot](https://github.com/toco/TOCScreenshot) 

## [Step 3](https://github.com/toco/RealmToDo/commit/64d4b4dc26ecd7a85d4df986187de9bdedf62367)
Beautify the statusbar using [SimulatorStatusMagic](https://github.com/shinydevelopment/SimulatorStatusMagic)

## [Step 4](https://github.com/toco/RealmToDo/commit/636a98330b15570dcd31fe92c47ccdf8aa50d1db)
Add schemes for the different localizations.
Add script to take screenshots for all devices and schemes

---

#Original by Piet:

This is a small application I did for the CocoaHeads in Hamburg on how to integrate Realm in a small project.

You can follow the steps I made with the git tags:

## v1

* Empty application with a simple UITableViewController

## v2

* Add a simple list that is backed by an array

## v3

* Add an ViewController that has an UITextField to enter a new item

## v4

* Add realm instead of the static array

## v5

* Add the ability to add a strikethrough to a finished item

## v6

* Add another section for the UITableView to display finished and unfinished items
