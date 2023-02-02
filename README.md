# Kanban Board

* This is an example Сlean Architecture + BLoC project to showcase my skills.
* I also tried to adhere to development principles such as DRY, KISS, SOLID, TDD and MVP (Minimum Viable Product).
* UI/UX Design and source code with tests was developed by me within approximately 40 working hours according to the
  following functional requirements:

    1. A kanban board for tasks, where users can create, edit, and move tasks between different columns (e.g. "To Do", "
       In Progress", "Done").

    2. A timer function that allows users to start and stop tracking the time spent on each task.

    3. A history of completed tasks, including the time spent on each task and the date it was completed.

    4. A way to export data to CSV file.

## Build and Run

* Set Flutter version to 3.7.1 in your environment
* In the project folder, run the following commands in order:
* Just follow these * steps for a quick start

##### 1. Clean Build

```flutter clean```

##### 2. Receive dependencies *

```flutter pub get```

##### 3. Upgrade dependencies

```flutter pub upgrade```

##### 4. Code generation *

```flutter packages pub run build_runner build --delete-conflicting-outputs```

##### 5. Run Tests

```flutter test```

##### 6. Run App *

Connect a real device to your computer and run the app with

###### Android

```flutter run --release --bundle-sksl-path flutter_android.sksl.json```

###### iOS

```flutter run --release --bundle-sksl-path flutter_ios.sksl.json```

##### 7. Build App

###### Android

* as apk ```flutter build app --bundle-sksl-path flutter_android.sksl.json```

* as appbundle ```flutter build appbundle --bundle-sksl-path flutter_android.sksl.json```

###### iOS

* as ios app ```flutter build ios --bundle-sksl-path flutter_ios.sksl.json```

* as ipa ```flutter build ipa --bundle-sksl-path flutter_ios.sksl.json```

## Warm up animations

Connect a real device to your computer and run the app with
```flutter run --profile --cache-sksl --purge-persistent-cache```
Now when your application starts running, try to trigger as many animations as you can especially those with the
compilation jank. After you have done that, press ```Shift+m``` in your command line to write the captured SkSL shaders
into a file named something like ```flutter_01.sksl.json```. Rename this file to ```flutter_ios.sksl.json```
or ```flutter_android.sksl.json``` according to device OS.

