---
layout: posts
title:  "First Game Jam"
date:   2020-09-03 08:59:00 -0500
category: archive
author: Aidan Velleca
thumbnail_link: "assets/images/movement.png"
description: "My experience in my first game jam"
published: false
---
*Note: This is ported content from my previous blog. It may appear in a format different than intended. It is also from a version of myself that was younger and dumber. I like to keep this content around for posterity.*

A few weeks ago, I participated in my first game jam for Brackey's Game Jam 2020.2. You can play my game here: [https://sunspotgamedesign.itch.io/packskulters](https://sunspotgamedesign.itch.io/packskulters). I also documented the process.

**Game Jam Log Day 1**

Day 1 was spent brainstorming and laying down the framework for the game. The theme for this game jam was “Rewind.” I spent about an hour trying to come up with something before I came up with something similar to chess, with some noticeable differences. First, the board is 9x9 instead of 8x8. Second, the outer squares are made up by a road. Third, and what incorporates the theme: if a character gets hit, it ‘rewinds’ to where it was before instead of being taken. Once I figured out how the game was going to go, I spend the day designing a tile map for the game. The tile map went through multiple iterations. The special event tiles (the ones with the exclamation marks) still have not been implemented into the game. I also made the background and set up the base support system for the pieces. What took the longest was creating an easy to navigate interface for each piece in the custom inspector. Each piece is a ScriptableObject with certain variables. What I hope to have happen is that on runtime the GameManager instantiates all pieces in their starting positions with references to their ScriptableObjects, and whenever you select a piece to move, it calculates the x and y distances in tiles from the current to new position and sees if it matches any relative positions in its ScriptableObject reference. There is still a lot more that needs doing. I need to draw out each piece so they have a ScriptableObject, write the GameManager, make the music, the rewind system, and more. Hopefully tomorrow I can at least move the pieces around. Below is an image of the board so far, I am quite fond of it.

**Game Jam Log Day 2**

I started Day 2 with some tweaks to the piece custom editor I made yesterday. Instead of “Piece Sprite,” I made two sprite fields, one for red and one for blue. I could have just used one sprite and color it red or blue on instantiation by the Game Manager based on the team, but I decided to create two different sprites in Inkscape (my image editor program of choice) because I wanted to use different shades of blue and red that wasn’t possible in Unity. I also drew all the pieces and coded their instantiation. I implemented code so that when a piece is clicked on the board, if it belongs to the team that is currently going a selection box is drawn around it. I implemented a function that loops through all tiles, checks its sprite to see if it is a road or grid, and then stores its type and position in a custom class array called TileInfo. I also started writing a function to check all the valid moves, which uses the valid moves array for the piece, the TileInfo, and the locations of all the pieces on the board to check if the function is legal, but did not finish.

**Game Jam Log Day 3**

Pieces now move! When you select a game object, a function runs to determine all the legal moves available to that piece. Then, the game waits for another mouse press. It gets the tile from the mouse press, and then it checks if that tile is a legal tile to move to. There are still some exceptions I need to code into this function, like if the tile type doesn’t match but there is a biker, or if there is a piece in the way of the move. After a move, the teams switch. That was all I did that day because I needed to catch up on schoolwork. Or so I thought. It turns out I had extra time later, and I coded the detection of a piece in the way. I encountered a couple of bugs along the way, but it worked out in the end. I also attempted to add the rewind feature when a piece is taken but did not have time to finish that day.

**Game Jam Log Day 4**

On the fourth day, I fully integrated the rewind feature. I also made it so that the bicycle is a valid move for the daggermen and foot soldiers that can reach it on their move. However, there are now some things I need to fix. The first is that, when attempting to move to a bike tile, you just select the bike, which is annoying. Second, if you try to move to the bicycle space, for some reason you don’t end up in the correct spot. Finally, rewinds mess up if the player doesn’t have enough moves to go back on. I plan to fix this by making it so that any null/(0,0,0) elements become the last defined element in the list.

**Game Jam Log Day 5**

I did some tweaking today to make things more efficient and finished up the bicycle mechanics. I added a UI window where you can see the piece that is on your bike at the moment. I also added the basic infrastructure for the AI to do stuff, it can now access all its pieces and is triggered after a move, but it doesn’t do anything. The rewind counter is now removed after all rewinds are spent. I need to polish the rewind event a little bit so that it does not rewind you to a position a player has since moved to. Also, there are still some finicky aspects of the game. Every piece moves to the correct position now (they used to not but it turns out you can’t have them on a canvas), but sometimes it seems that a team can get two turns. I haven’t debugged enough to tell. But any time I have tomorrow will be spend debugging the moves, creating the AI, and possibly adding the mega rewind event so that hopefully on Friday, the last day, all I need to do is polish it off with a main menu, some music, and better art.

**Game Jam Log Day 6**

On this day, I implemented the win condition (no pieces left other than the biker) and worked heavily on the piece AI, which moves every blue’s turn right now. I struggled to find a plan for the AI. At first, I thought it should prioritize smaller pieces if they can move and then bigger pieces. This had unexpected issues. I also wanted it to think two moves ahead. I got a rough version, but it definitely needs to be improved later.

**Game Jam Log Day 7**

This is the day everything was due. I made final adjustments to the characters, added a title screen and a help screen, and implemented in the music I had made. It only plays on the first panel. Upon submission, I got a ton of errors, and at one point my sorting layers got removed and I had to recreate them. The win screen didn’t show up properly in the game window because I forgot to fix the sorting layer on it, and the AI didn’t work as well as I wanted it to, but overall it was a success. In the future, I’d like to fix these things, as well as a bug a player noticed about the biker being able to take the other one.
