# HTLTW Agent Notes

HTLTW is a narrative game built with the Love2D Lua engine. Its screen layout and mood take inspiration from games such as "Citizen Sleeper", "Norco", and "Disco Elysium".

Code structure and implementation patterns should take inspiration from these CS50 game examples:

- https://github.com/games50/pokemon
- https://github.com/games50/zelda

## Core Game Shape

- Window size is 1280x720.
- The left 960x720 area is the visual stage.
- The right 320x720 area is the narrative text panel.
- Graphical assets live in `graphics/`.
- Audio assets live in `sounds/`.
- Third-party utilities live in `lib/`.
- Game source code lives in `src/`.
- State classes live in `src/states/`.
- Future game object and scene support should live under `src/world/` or another clearly named `src/` subfolder.

## Narrative Content

Narrative content will be prepared in inklewriter and provided as a JSON file.

Do not overbuild the narrative system before the JSON shape is known. Until then, keep scene text local and simple.

## Libraries And Patterns

Use these libraries when implementing game systems:

- `lib/class.lua` for all classes.
- `lib/push.lua` for window scaling and presentation.
- `lib/knife` utilities when they simplify the implementation.

Avoid hand-written class/metatable patterns for new classes unless there is a strong reason.

## Documentation Workflow

Before writing new code, prepare or update `docs/architecture.md`.

Read `docs/decisions.md` when making technical or design choices. This file records decisions that should guide implementation.

`TODO` comments in source files indicate future tasks.

## Current Decisions

The current decisions from `docs/decisions.md` are:

- First scene: draw `graphics/ch_01.png` on the left and the text `HTLTW` on the right.
- Use `lib/class.lua` for all classes.
- Use `push.lua` and `lib/knife` utilities for future functionality whenever they simplify the code.

## Current Project State

The project has been brought to a minimal runnable Love2D scaffold:

1. `docs/architecture.md` was created to describe the fixed layout, runtime flow, source organization, and near-term direction.
2. `main.lua` was added as the Love2D entry point.
3. `src/Dependencies.lua` was added as the central require file.
4. `src/constants.lua` defines the 1280x720 window, 960x720 visual stage, and 320x720 text panel.
5. `src/StateMachine.lua` implements a small state machine using `lib/class.lua`.
6. `src/states/BaseState.lua` defines no-op state callbacks.
7. `src/states/StartState.lua` renders the first scene with `graphics/ch_01.png` and `HTLTW`.
8. `main.lua` now uses `push.lua` for drawing.
9. Lua syntax was checked with `luac -p`.

## Local Environment

Love2D is aliased locally to:

```text
/Users/tomas/Downloads/lua/love.app/Contents/MacOS/love
```

Use that executable path when running the game from the terminal if the `love` command is not on the shell path.
