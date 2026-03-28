# bath-hack-2026

pico-8 install: https://drive.google.com/drive/folders/1Z89zuvt-0Fl6fMpKub6m3dGGPTUTTQ8D?usp=sharing

## Notes

- Try to keep variable names short
- INDENT USING TABS so it only uses one character

## Printh

You can print to console for debug statements. See https://pico-8.fandom.com/wiki/Printh#Running_PICO-8_in_a_console_window.

## Comment Remover

I use a script so comments can be as long as needed without bumping into character limit.

Run the build task any time you want to "save" your progress (as well as saving manually I guess).

This means there are some steps you need to follow to create new organisation `.lua` files.

1. Create your file.
    1. `new.lua`
2. Add this line to `./.vscode/tasks.json` within the `args` list.
    1. `"new.lua", "new_out.lua",`
3. Add this line to `fake.p8`.
    1. `#include new.lua`
4. Add this line to `bh26.p8`.
    1. `#include ./output/new_out.lua`

