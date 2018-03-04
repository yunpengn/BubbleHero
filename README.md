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

### Rules of Your Game

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
12. Special bubbles allow chaining effect. On the one hand, any special bubble itself removed by the special effect of another special bubble will be triggered; on the other hand, the same-type neighbors of a special bubble being triggered will also be triggered.
13. The score is calculated according to the reason a bubble is removed: same-color - 5 points, star - 10 points, lightning - 12 points, bomb - 15 points, falling - 8 points.

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

There are a few ways to integrate the game engine and they are discussed as follows:

-

### Problem 4.4

There are generally two ways to implement these special behaviours:

- **Current approach**: add the different logic in `GameViewShootingController`. Although the disadvantage is that `GameViewShootingController` will become longer, it is still a better approach. All logic for interactions between bubbles are within one class and this class does nothing else, which is following single responsibility principle. If we want to add new types in the future, we simply need to add more `case`s in the `switch` statements, which is simple to do.
- Subclass `BubbleObject` for each special bubbles. This alternative is good because we can separate the logic for each type of special bubbles. However, it can be much more complicated. We need to have separate logic when loading the level, which adds more logic to `GameViewController`. And the coupling is higher and single responsibility principle is violated. Take lightning bubbles as an example. To trigger lightning effect, we need to find and remove all bubbles on the same row. That means, `LightningBubbleObject` class now tries to manage all bubbles in the game, which is actually the responsibility of `GameViewShootingController`. Also, if we add a new type of bubble in the future, we may need to modify all subclasses of `BubbleObject`.

### Problem 7: Class Diagram

![Class Diagram](class-diagram.png)

### Problem 8: Testing

Your answer here

### Problem 9: The Bells & Whistles

Your answer here

### Problem 10: Final Reflection

Your answer here
