CS3217 Problem Set 5
==

**Name:** Niu Yunpeng

**Matric No:** A0162492A

**Tutor:** Louie Tan

## Tips

1. CS3217's Gitbook is at https://www.gitbook.com/book/cs3217/problem-sets/details. Do visit the Gitbook often, as it contains all things relevant to CS3217. You can also ask questions related to CS3217 there.
2. Take a look at `.gitignore`. It contains rules that ignores the changes in certain files when committing an Xcode project to revision control. (This is taken from https://github.com/github/gitignore/blob/master/Swift.gitignore).
3. A Swiftlint configuration file is provided for you. It is recommended for you to use Swiftlint and follow this configuration. Keep in mind that, ultimately, this tool is only a guideline; some exceptions may be made as long as code quality is not compromised.
4. Do not burn out. Have fun!

## Acknowledgements

We would like appreciate the wonderful resources provided by the following websites:
- Pexels [https://www.pexels.com]
- Flat Icons [https://www.flaticon.com]
- Sound Bible [http://soundbible.com]
- Free Music Archive [http://freemusicarchive.org]

## Rules of Your Game

1. Make sure you have uninstalled all previous (or older) versions of _Bubble Hero_.
2. Install and open the game, you should see `Start`, `Design`, `Settings` and `About` four buttons.
3. `Start` button will lead to the level selection screen, `Design` will lead to the level designer screen, both of which will be discussed in details as follows.

##### Level Designer
1. You can select all different types of bubbles from the palette to fill the bubble grid. They include 4 basic types (blue, green, yellow & red) and 5 special types (indestructible, lightning, bomb, star & magnetic). You can also use the eraser to erase filled bubbles.
2. `Back` button will lead you back to the main menu screen.
3. `Start` button will start a new game with the current design (but will not save the design).
4. `Save` button will allow you to save the current design (and thus can be used later). The name of the level design can only include alphanumeric characters (both upper-size and lower-case). It cannot be empty or the same as any previous design that has been saved.
5. `Load` button will lead to the level selection screen, in which you can select a previously-saved design and continue your design based on it. Long-press will delete a previously-saved design.
6. `Reset` will clear all bubbles in the current design, which is irreversible. You need to confirm this action.

##### Level Selection
1. You can single-tap to select any level, long-press to delete any level.
2. If you come from level designer, it will go back to level designer screen after single-tap; if you come from menu screen, it will start a new game after single-tap.
3. If you come from menu screen, the last item in level gallery will be marked with a question mark, which denotes it is a random level design automatically generated. You can select it to start a game for fun. This random design cannot be deleted.
4. When you open the game for the first time, three levels will be pre-loaded for you. You can design more levels on your own.

##### Game Play
1. Each game has a time limit of 90 seconds. The ultimate goal is to earn more points. Removing more bubbles does not necessarily mean higher score. We appreciate your wisdom.
2. The cannon below will be used to shoot bubbles. You should drag (rather than single-tap) to launch bubbles. The cannon will face towards the direction of your finger.
3. The two bubbles at the right bottom of the screen shows the next & next second bubbles to be launched, which can be a useful hint.
4. The time at the left bottom of the screen shows the time left. You cannot shoot bubbles anymore when time is up.
5. The cannon will launch only basic-type (blue, green, yellow & red) bubbles (either snapping or non-snapping).
6. You can only launch the next bubble after the current bubble stops.
7. If no special effect is triggered, same-color bubbles will be removed only if they form a connected group of at least 3.
8. Hanging bubbles (not attached to the top wall, either directly or indirectly) will always be removed.
9. If any launched bubble touches a bomb bubble, the bubbles around the bomb will be removed and you should hear an explosion sound effect. The bomb itself will also be removed. _Notice that sometimes you may feel a non-snapping bubble "around" the bomb is not removed, this is because there exists some space between the non-snapping bubble and the bomb (which may be invisible)._
10. If any launched bubble touches a lightning bubble, any bubble on the same row as the lightning bubble will be removed and you should hear a thunder sound effect. The lightning bubble itself will also be removed. _Notice that most likely non-snapping bubbles cannot be removed by a lightning bubble, because their height is not an integer multiple of the standard height value._
11. If any launched bubble touches a star bubble, any bubble with the same color as the launched bubble will be removed. The star bubble itself will also be removed.
12. Indestructible bubbles and magnetic bubbles can only be removed by special effects or by falling.
13. Magnetic bubbles will attract the launched bubbles, whose force is inverse proportional to the square of the distance between them.
14. Special bubbles allow chaining effect. On the one hand, any special bubble itself removed by the special effect of another special bubble will be triggered; on the other hand, the same-type neighbors of a special bubble being triggered will also be triggered.
15. Bubbles with a purple border are non-snapping ones. They will not snap to the standard cells. Instead, they will stop immediately after they touch any other bubbles. However, they are also normal color bubbles. They can also be removed when forming a connected same-color group of at least 3. Any later launched bubbles which touch it will also become non-snapping.
16. The score is calculated according to the reason a bubble is removed: same-color - 5 points, star - 10 points, lightning - 12 points, bomb - 15 points, falling - 8 points.

### Problem 1: Cannon Direction

1. The cannon below will be used to shoot bubbles.
2. You should drag (rather than single-tap) to launch bubbles. Your finger should be a height higher than the cannon.
3. The cannon will face towards the direction of your finger, which will be the direction in which the bubble will be launched.

### Problem 2: Upcoming Bubbles

A `BubbleSource` type is implemented to support the decision of the colors of the next few bubbles. This `BubbleSource` is in turn supported by a customize data structure called `FixedQueue`.

A `FixedQueue` is still a queue, meaning that it still supports first-in & first-out behavior (FIFO). However, it is fixed size, meaning that the number of items inside it is fixed. Its size is determined by the size of array passed in during initialization. Whenever an item is popped (or dequeued), a new item must be pushed (or enqueued) at the same time. Let's the size of a `FixedQueue` is `n`, you can always safely get the item at index `m` (where `0 <= m < n`) because its size is fixed.

`FixedQueue` helps `BubbleSource` to maintain its data integrity. If we want to display next `x` bubbles, we just need a `FixedQueue` with size `x`. Whenever a new bubble is launched, we dequeue an item and enqueue a random new one at the same time. The next few bubbles can be displayed because we can safely get the item at index `m` (where `0 <= m < x`).

The new items enqueued are randomly generated: first we determine its type(among all 4 basic color types) and then decide whether it is snapping.

### Problem 3: Integration

In some sense, there are generally two integration approaches, top-down integration and bottom-up integration. The current choice is top-down integration.

- **Current approach**: This approach is more suitable in this problem set. The major advantage is that we can find problems earlier. Top-down approach requires us to look at the problem at a larger scale, without focusing too much on the details. Thanks to problem set 4, the requirements and functionalities of a game engine should be clear now. Thus, we can just list out all the APIs of the game engine and let the controllers for the game to call these APIs. Then, we need to check whether all requirements can be fulfilled by only using these APIs. If not, we can find out earlier and change the APIs. One possible disadvantage is that we have to be very clear about the requirements.
- Alternative: This approach is easier and is more suitable we start from scratch and are not really sure about the requirements. We can try to integrate small components first and see how along the way. However, this is dangerous because major problems may be delayed to be observed. The public APIs will determine the whole internal implementation of the game engine. If we use bottom-up approach, it is possible that we suddenly find we have to re-write the whole thing at a later stage.

### Problem 4.4

There are generally two ways to implement these special behaviours:

- **Current approach**: add the different logic in `GameViewShootingController`. Although the disadvantage is that `GameViewShootingController` will become longer, it is still a better approach. All logic for interactions between bubbles are within one class and this class does nothing else, which is following single responsibility principle. If we want to add new types in the future, we simply need to add more `case`s in the `switch` statements, which is simple to do.
- Subclass `BubbleObject` for each special bubbles. This alternative is good because we can separate the logic for each type of special bubbles. However, it can be much more complicated. We need to have separate logic when loading the level, which adds more logic to `GameViewController`. And the coupling is higher and single responsibility principle is violated. Take lightning bubbles as an example. To trigger lightning effect, we need to find and remove all bubbles on the same row. That means, `LightningBubbleObject` class now tries to manage all bubbles in the game, which is actually the responsibility of `GameViewShootingController`. Also, if we add a new type of bubble in the future, we may need to modify all subclasses of `BubbleObject`.

### Problem 5

See description in the rules of the game.

### Problem 7: Class Diagram

![Class Diagram](class-diagram.png)

### Problem 8: Testing

#### Black-box testing

- Test menu screen
    - When clicking on the `start` button, I expect level selection screen to show.
    - When clicking on the `design` button, I expect level designer screen to show.
    - When clicking on the `settings` button, I expect the settings screen to show.
    - When clicking on the `about` button, I expect the about screen to show.
    - I expect the background music to be playing.
- Test level designer
    - When user selects any bubble buttons (9 bubbles + 1 eraser) in the palette, the selected one should look different from the else.
    - You can single tap on each of 9 bubble buttons to select it, tap again to deselect it; only one of them can be selected at the same time.
    - Initially, the bubble grid should be empty and no bubble should be filled.
    - When user presses the `Reset` button but does not confirm, nothing should change.
    - When user presses the `Reset` button and confirms, all filled bubbles should be cleared and bubble grid goes back to the initial state.
    - When user presses the `Start` button, I expect the game play screen to show.
    - When user single-taps on or drags across any cell in the bubble grid, it  should be changed to the same type as the selected bubble in the palette (of any of the 9 bubbles is selected). The original color will be replaced if the cell has been filled before.
    - When user single-taps on or drags across any cell in the bubble grid, its color should be cleared if the eraser is selected. Nothing will happen if the cell is not filled at all.
    - When user single-taps on any **filled** cell in the bubble grid, its color should be cycled (blue -> green -> orange -> red -> blue -> ...) if no bubble button in the palette is selected.
    - When user long presses on any **filled** cell in the bubble grid, its color should be cleared. Nothing will happen if the cell is not filled at all.
    - When user presses the `Load` button, the level selection view should be shown. A level gallery will be displayed and show all previously saved levels (with a screenshot preview and its name).
- Test level selection
    - When coming from the menu screen, pressing the green back button on the left top will go back to menu.
    - When coming from the level designer screen, pressing the green back button on the left top will go back to level designer.
    - When coming from the menu screen, single-tap on any level design screenshot will start a game with that level and show game play screen.
    - When coming from the level designer screen, single-tap on any level design screenshot will load that level and allow continuing design based on this and show game play screen.
    - Long-ress on any level design screenshot, I expect a dialog window to open and ask me to confirm whether to delete that level
        - If confirm, I expect the level gallery to have one fewer level design.
        - If not confirm, I expect nothing changes.
- Test game play
    - Test the launch of a bubble
        - When I drag and release on a location of the screen that is not at least slighlt higher than the position of the bubble launcher, I expect the input is rejected and nothing will happen.
        - When I already have a shooted bubble travelling (collision not happened yet), I expect the input is rejected and nothing will happen.
        - Otherwise, I expect the bubble is launched in the direction towards the point of the single-tap gesture.
        - I expect only basic color type bubbles to be launched.
        - I expect both snapping bubbles and non-snapping bubbles to be launched, of which the latter has a much lower probability.
    - Test the movement of a bubble
        - When a bubble has been launched (shooted) successfully, I expect the travelling speed to be a positive constant. I also expect the bubble travels in a staight line (as long as no collision with screen edge or other bubbles happen).
        - When a bubble is falling down, I expect it to be a free falling process (without the effect of air resistance), i.e., its acceleration is a positive constant. Visually, the velocity should increase (although human eyes may not be able to observe the change). I also expect the falling down in straight downward direction.
    - Test collision between two basic color type bubbles
        - When a shooted bubble collides with a remaining static bubble, I expect the shooted bubble to stop moving and snap to the nearest empty cell.
        - Following above, when there are at least 3 connected bubbles of the same color, I expect them to be removed with a fading away effect.
        - Following above, when there are bubbles unattached to the top wall, I expect them to be removed by falling down out of the screen.
        - When a shooted bubble "collides" with a falling bubble, I expect no collision will happen and they will bypass each other.
    - Test collision between a bubble and a screen edge
        - When a shooted bubble collides with the side wall (left or right), I expect a reflection happens. In other words, the (horizontal component of the) moving direction of the bubble should reverse.
        - When a shooted bubble collides with the top wall, I expect it to stop moving and snap to the nearest empty cell.
        - Following above, after snapping to the nearest empty cell, normal behavior should happen if it collides with any other static bubble.
    - Test bomb bubble: When a launched bubble touches a bomb, I expect the burst effect to be seen on all neighbors of the bomb (after which they will disappear), and hear an explosion sound effect.
    - Test lightning bubble: When a launched bubble touches a lightning bubble, I expect all bubbles on the same row to disappear. Also, there is a blinky white line on the same height as the center of the lightning bubble.
    - Test star bubble: When a launched bubble touches a star bubble, I expect all bubbles with the same color as the launched bubble to disappear.
    - Test magnetic bubble: When a launched bubble goes nearby a magnetic bubble, I expect magnetic bubbles will attract the launched bubbles, whose force is inverse proportional to the square of the distance between them.
        - I expect magnetic bubbles to lose magnetism when they fall down.
        - I expect magnetic bubbles to not attract falling bubbles (no matter whether they themselves are falling).
    - Test chaining effect:
        - I expect any special bubble itself removed by the special effect of another special bubble will be triggered;
        - I expect the same-type neighbors of a special bubble being triggered will also be triggered.
    - Test non-snapping bubbles:
        - I expectnon-snapping bubbles to have a purple border.
        - I expect they will not snap to the standard cells. Instead, they will stop immediately after they touch any other bubbles.
        - I expect they are also normal color bubbles. They can also be removed when forming a connected same-color group of at least 3.
        - I expect any later launched bubbles which touch it will also become non-snapping.
    - Test scores:
        - For each removed bubble, I expect a tiny white-color label to show the number of points added.
        - Same-color - 5 points, star - 10 points, lightning - 12 points, bomb - 15 points, falling - 8 points.
    - Test timer:
        - When the time left > 1min, I expect the text color to be white.
        - When 0.5min < the time left < 1min, I expect the text color to be yellow.
        - When the time left < 0.5min, I expect the text color to be red.
        - I expect the text to be updated per second.
        - I expect the timer to stop after reaching 0 and the game view screen to be shown.
    - Test next two bubbles:
        - I expect the next two bubbles to be shown on the bottom right of the screen.
        - I expect the next second bubble to be a bit smaller than the next bubble.
- Test game win screen
    - I expect the win screen to be shown over the game play screen. Its background should be transparent such that the game play screen still can be seen, albeit cannot launch bubbles anymore.
    - I expect the level name and total score to be shown correctly.
- Test settings screen
    - I expect the background music checkbox to be initially checked and the background music is playing.
    - When clicking on the checkbox, I expect the checkbox to be unchecked and the music pauses.
    - When clicking on the checkbox again, I expect the checkbox to be checked and the music resumes.
- Test about screen
    - When clicking on the middle image for only once or twice, I expect nothing should happen.
    - When clicking on the middle image for much more times, I expect the image to change.
    - When clicking on the middle image for even more times, I expect the image to change again.

#### Glass-box testing

According to software testing cost & benefit [analysis](https://www.agileconnection.com/sites/default/files/article/file/2014/Cost-Benefit%20Analysis%20of%20Test%20Automation.pdf), glass-box testing may not be the most suitable method.

### Problem 9: The Bells & Whistles

The following extra features are added to the game:

- When a bomb bubble is triggered, the sprite `bubble-burst.png` will be used to animate and there is an explosion sound effect.
- When a lightning bubble is triggered, there is a blinky white line to simulate the effect and there is a thunder sound effect.
- Each removed bubble will add some scores. The scores added are different according to the reason the bubble is removed. And the total score will be shown when the game stops.
- Adds the end-game screen to tell the user the level name and scores obtained.
- Adds a time limit to the game and user should try to get higher scores in the limited time. The text color for the label at the left-bottom of the screen will change according to the time left.
- Adds background music and adds a setting screen to turn on/off the background music.

### Problem 10: Final Reflection

Comparing the original MVC architecture and the current one, the model part does not change much (albeit certainly more classes). The controller part changes a lot. I have tried to reduce the problem of massive view controller. Thus, delegate pattern is heavily adopted. In the view part, I created more custom view elements. The details are discussed as follows.

- **Model**: The model in Swift's MVC is more similar to the traditional OOP we do in Java. However, if I can further improve this part, I would fully use `struct` and `enum` (rather than class). This is safer and may lead to fewer bugs. It is also accorded with Swift's philosophy. Accompanied with this, I would begin to prefer composition rather than inheritance. I gradually find that we really do not need inheritance sometimes (although on the other hand, we do need them sometimes).
- **Controller**: Through this series of problem sets, I believe the top one thing I learn is how to decouple and adopy SRP. This is much related to reducing the problem of massive view controllers. To pass notification between multiple controllers, we can adopt delegate pattern. While, all controllers should share the data from model. For some controllers like `BackgroundMusicController`, they are more like service pattern although it is called a controller. When instantiating a `BackgroundMusicController`, we can think of booking a service (or component) to play the music for us.
- **View**: I used a lot of custom UI elements. On the one hand, this is because the given elements in `UIKit` cannot suit the needs. On the other hand, this helps to reduce the massive view controller problem as well. If we only use the system-given UI elements, we may need to write more to update the view. Let's we have a custom `UIView`, which has three states. To convert to each one of the states, we may need to write a method of about 10 lines. Instead, we should actually move this method into the class for the custom UI element. Thus, controller should not really update view. Instead, the controller should tell the view to update. The view itself should control the details about how to update. Of course, data still need to be passed in by controllers.
