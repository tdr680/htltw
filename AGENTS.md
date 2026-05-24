This is a game with basic layout like "Citizen Sleeper", "Norco" or "Disco Elysium" using Lua Love engine. 

It's called "HTLTW" and patterns used in the game like state machine, scenes management, etc. will take inspiration from following repositories: https://github.com/games50/pokemon and https://github.com/games50/zelda.

Narrative part will be prepared in inklewriter and provided as json file.

Graphical assets will be delivered to the directory "graphics".

Audio assets will be delivered to the directory "sounds".

Directory lib will contain knife, class, push utilities.

Directory src will contain the subfolders for states, game objects and other necessary lua sources.

Dimension of the window will be 1280x720, left part 960x720 will be the graphic part, right part 320x720 will contain the text. 

Before writing new code, prepare docs/architecture.md.

Sometimes it is useful to read docs/decisions.md to see technical and design choices made.
