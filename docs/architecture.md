# HTLTW Architecture

HTLTW is a Love2D narrative game with a fixed 1280x720 presentation. The screen is split into a 960x720 visual stage on the left and a 320x720 text panel on the right. The project structure follows the small, explicit style used in the CS50 Pokemon and Zelda examples: one Love entry point, shared constants, `lib/class.lua` classes, a simple state machine, and scene-specific state files.

## Project Layout

```text
main.lua              Love2D entry point.
graphics/            Delivered visual assets.
sounds/              Delivered audio assets.
lib/                 Third-party helpers: class, push, and knife utilities.
src/                 Game source files.
src/states/          State machine states.
src/world/           Scene, character, and object code when needed.
docs/                Architecture notes and design decisions.
```

## Runtime Flow

`main.lua` loads `src/Dependencies.lua`, configures the window through `push`, creates the global state machine, and delegates update and draw calls to the active state.

`src/Dependencies.lua` is the central require file. It loads constants, framework helpers, and states in one place so `main.lua` stays small. Class-like modules should use `Class = require 'lib/class'`. Knife utilities should be required only when they simplify the implementation.

`src/StateMachine.lua` owns transitions between states. Each state may implement `enter`, `exit`, `update`, and `render`.

`src/states/BaseState.lua` provides no-op methods so individual states only implement the callbacks they need.

## Screen Regions

The game uses two fixed layout regions:

```text
0,0      960x720  Visual stage
960,0    320x720  Narrative text panel
```

The first scene draws `graphics/ch_01.png` into the visual stage and the text `HTLTW` in the right panel.

## Narrative Data

Narrative content will be exported from inklewriter as JSON. Once the final JSON shape is available, the project should add a narrative loader under `src/world` or `src/narrative`, then expose scene text and choices to the active state. Until that format is known, scene text should stay simple and local to the state that renders it.

## Asset Conventions

Graphics are read from `graphics/`. The current scene images are already authored at 960x720, matching the visual stage exactly. Audio files should be added under `sounds/` and loaded by state or by a later audio manager once repeated use appears.

## Near-Term Direction

Keep the first implementation deliberately small:

1. Establish a runnable Love2D window.
2. Render the first scene with the required split layout.
3. Add transitions and narrative JSON parsing only when there is more than one scene or real story data to load.
