# HTLTW Agent Notes

HTLTW is a narrative game built with the Love2D Lua engine. Its screen layout and mood take inspiration from games such as "Citizen Sleeper", "Norco", and "Disco Elysium".

Code structure and implementation patterns should take inspiration from these CS50 game examples:

- https://github.com/games50/pokemon
- https://github.com/games50/zelda

`AGENTS.md` is now the single source for project architecture, implementation decisions, and future direction. Do not create or rely on separate `docs/architecture.md` or `docs/decisions.md` files.

## Core Game Shape

- Window size is 1280x720.
- The left 960x720 area is the visual stage.
- The right 320x720 area is the narrative text panel.
- Graphical assets live in `graphics/`.
- Audio assets live in `sounds/`.
- Third-party utilities live in `lib/`.
- Game source code lives in `src/`.
- State classes live in `src/states/`.
- Narrative loading code lives in `src/narrative/`.
- Scene and world presentation code lives in `src/world/`.

## Project Layout

```text
main.lua              Love2D entry point.
graphics/            Delivered visual assets.
sounds/              Delivered audio assets.
lib/                 Third-party helpers: class, push, lunajson, and knife utilities.
src/                 Game source files.
src/states/          State machine states.
src/narrative/       Story loading and inklewriter JSON helpers.
src/world/           Scene, character, and object code.
AGENTS.md            Architecture, decisions, and future direction.
```

## Runtime Flow

`main.lua` loads `src/Dependencies.lua`, configures the window through `push`, creates the global state machine, and delegates update and draw calls to the active state.

`src/Dependencies.lua` is the central require file. It loads constants, framework helpers, narrative helpers, and states in one place so `main.lua` stays small.

`src/StateMachine.lua` owns transitions between states. Each state may implement `enter`, `exit`, `update`, and `render`.

`src/states/BaseState.lua` provides no-op methods so individual states only implement the callbacks they need.

`src/narrative/Story.lua` loads inklewriter JSON through `lunajson` and exposes stitch text and options to states. Narrative data should be accessed through this module instead of being parsed directly inside state files.

`src/world/Scene.lua` owns left-stage rendering. It receives the active stitch id, looks for a matching image, and renders a blank stage when no matching image exists.

`PlayState` owns the first narrative interaction. It tracks the active stitch, delegates left-stage rendering to `Scene`, renders that stitch's text and options, and handles mouse interaction with those options. A larger scene controller should only be introduced once this logic grows beyond the first scene.

## Screen Regions

The game uses two fixed layout regions:

```text
0,0      960x720  Visual stage
960,0    320x720  Narrative text panel
```

The first scene draws `graphics/aTeacherYesThats.png` into the visual stage. The right panel renders story text from the first inklewriter stitch, `aTeacherYesThats`, in `narrative/part_01.json`.

## Narrative Content

Narrative content is prepared in inklewriter and exported as JSON.

The current story export is:

- `narrative/part_01.json`

The observed structure uses:

```text
title
data.initial
data.stitches
data.stitches[stitchId].content
```

Each stitch `content` array may contain plain text strings and metadata tables. Option tables include `option` and `linkPath`, which can later become selectable choices.

`Story` should:

1. Load an inklewriter JSON file.
2. Resolve the initial stitch from `data.initial`.
3. Return the text fragments for a stitch.
4. Return available options for a stitch.

Option interaction should use the option table's `linkPath` to choose the next stitch. The state should then refresh both text and options from `Story`.

## Libraries And Patterns

Use these libraries when implementing game systems:

- `lib/class.lua` for all classes.
- `lib/push.lua` for window scaling and presentation.
- `lib/lunajson.lua` for JSON parsing.
- `lib/knife` utilities when they simplify the implementation.

Avoid hand-written class/metatable patterns for new classes unless there is a strong reason.

When using `lunajson`, require it as:

```lua
lunajson = require 'lib/lunajson'
```

The local `lib/lunajson.lua` file requires its submodules with repo-relative Love2D paths:

```lua
require 'lib/lunajson/decoder'
require 'lib/lunajson/encoder'
require 'lib/lunajson/sax'
```

## Decisions

- Stitch-specific images live in `graphics/` and should be named after their stitch id, for example `graphics/aTeacherYesThats.png`.
- If the active stitch has no matching image, the left visual stage should be blank.
- `Scene` owns left-stage image lookup, caching, and rendering.
- First scene: draw `graphics/aTeacherYesThats.png` on the left. The original right-panel placeholder was `HTLTW`.
- Use `lib/class.lua` for all classes.
- Use `push.lua` and `lib/knife` utilities for future functionality whenever they simplify the code.
- `narrative/part_01.json` contains part of the inklewriter story.
- `PlayState` should output the first stitch, `aTeacherYesThats`, in the right panel.
- Right-panel options should be interactive with the mouse. On mouse press, clicking an option should change the right-panel text to that option's target stitch.
- Future architectural and technical decisions should be recorded in this file.

## Current Project State

The project has been brought to a minimal runnable Love2D scaffold:

1. `main.lua` is the Love2D entry point.
2. `src/Dependencies.lua` is the central require file.
3. `src/constants.lua` defines the 1280x720 window, 960x720 visual stage, and 320x720 text panel.
4. `src/StateMachine.lua` implements a small state machine using `lib/class.lua`.
5. `src/states/BaseState.lua` defines no-op state callbacks.
6. `src/states/PlayState.lua` renders the first scene and delegates left-stage image rendering to `src/world/Scene.lua`.
7. `main.lua` uses `push.lua` for drawing.
8. `lib/lunajson.lua` is available for JSON parsing.
9. `src/narrative/Story.lua` loads inklewriter JSON and exposes stitch text and options.
10. `PlayState` renders stitch `aTeacherYesThats` from `narrative/part_01.json` and displays its options.
11. Lua syntax has been checked with `luac -p`.
12. `lunajson` has been smoke-tested against `narrative/part_01.json`.
13. `main.lua` delegates mouse presses to the active state.
14. `PlayState` stores clickable option bounds and switches to the clicked option's `linkPath` stitch.
15. `graphics/ch_01.png` was renamed to `graphics/aTeacherYesThats.png`.
16. `graphics/ch_02.png` was renamed to `graphics/byFourOclockTheP.png`.
17. `src/world/Scene.lua` renders `graphics/<stitchId>.png` when present and a blank left stage when missing.

## Suggested Next Implementation

The next code change should improve option presentation and interaction feedback.

Suggested steps:

1. Add hover styling for options in the right panel.
2. Add spacing that adapts to longer option text.
3. Add a graceful end-state display for stitches without options.
4. Consider moving text layout constants into `src/constants.lua` if the panel UI grows.

## Workflow

Before writing new code, read this file.

When making architectural or technical choices, update this file directly.

`TODO` comments in source files indicate future tasks.

## Local Environment

Love2D is available locally at:

```text
/Users/tomas/Downloads/lua/love.app/Contents/MacOS/love
```

Use that executable path when running the game from the terminal if the `love` command is not on the shell path.
