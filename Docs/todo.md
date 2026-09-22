# Ember Quickshell Todo List

A todo list and just general notes for tracking ideas

## Data singletons

1. Workspaces / Hyprland stuff
2. SystemMonitor
3. Media - MPRIS
4. Audio
5. Bluetooth
6. Network / Wifi stuff
7. Weather
8. Calendar, reminders or a "Today" type window that displays useful today information.

## Components

1. EmberClock - Takes the ClockDisplay and styles it with additional other components.
2. EmberMark - Basically a styled glyph for different states. Default state = "mountain", Music state = "some music thing"
3. Gauges - Styled gauges with ember glow effect. Resusable on bars or system monitoring type stuff.
4. Music Waveform - need something interesting and non standard.
5. Workspace Dots - component for expanded bar

## Ideas

### Compact

#### Changes

Keep the EmberMark, remove the buttons

Maybe adjust the ember mark depending on:

1. Music playing
2. Notification
3. Normal

#### Fixes

EmberMark and other components need to derive from profiles so dimensions work easier

### Expanded Bar

Rework the expanded surface size - make it smaller and more square, show workspace as dots

#### Layout

```
[{Workspace dots} | {time} |  {system monitor} | {buttons/system}]
```

### Other Surfaces

1. Music
2. Expanded surfaces / popout windows
