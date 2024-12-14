---
title: iTerm2
---

### Keyboard shortcuts

#### Cursor

| Key combination | Action                                                              |
| --------------- | ------------------------------------------------------------------- |
| Ctrl+A          | Jump to begining of line.                                           |
| Ctrl+E          | Jump to end of line.                                                |
| Ctrl+XX         | Jump to begining of line and then back to previous cursor position. |

#### Text

| Key combination | Action                                               |
| --------------- | ---------------------------------------------------- |
| Ctrl+D          | Delete character under the cursor.                   |
| Ctrl+T          | Swap the two characters before and after the cursor. |
| Ctrl+K          | Cut line from cursor to end of line.                 |
| Ctrl+W          | Cut word from cursor to beginning of word.           |
| Ctrl+U          | Cut line.                                            |
| Ctrl+Y          | Paste what has been cut.                             |
| Ctrl+I          | Insert tab character.                                |
| Ctrl+J          | Insert newline character.                            |

#### Process

| Key combination | Action                                                                        |
| --------------- | ----------------------------------------------------------------------------- |
| Ctrl+C          | Kill running process.                                                         |
| Ctrl+Z          | Pause running process, restart in background with `bg`, foreground with `fg`. |

#### Emulator

| Key combination | Action                              |
| --------------- | ----------------------------------- |
| Ctrl+L          | Clear screen.                       |
| Ctrl+\_         | Undo last key press.                |
| Ctrl+S          | Forward search in command history.  |
| Ctrl+R          | Backward search in command history. |
| Ctrl+O          | Run command found with search.      |
| Ctrl+G          | Exit search.                        |

### Preferences: Backup & Restore

Note: the "Expert all settings and data" in General > Settings seems to work
well, so the procedure below should not be needed anymore.

On the machine with a configured iTerm2:

1. Go to iTerm2's preferences, in General > Settings.
2. Check "Load settings from a custom folder or URL."
    * A pop-up opens prompting you to choose a folder. Choose the folder in which
     you want to **save** your iTerm2 settings.
    * A new pop-up opens asking "Copy local settings to custom folder now?",
     click "Copy".
3. In the "Save Changes" dropdown list, select "Manually" and then click on
   "Save Now".
4. The settings have been saved in the folder you choose, the file is
   `com.googlecode.iterm2.plist`.

On the machine with a default iTerm2:

1. Go to iTerm2's preferences, in General > Settings.
2. Check "Load settings from a custom folder or URL."
    * This time, choose the folder in which the saved
     `com.googlecode.iterm2.plist` resides.
    * If asked "Copy local settings to custom folder now", click on "Don't copy."
3. Wait a bit and then restart iTerm2.
4. iTerm2 should now have the new imported configuration.
5. Go to the preferences and uncheck "Load settings from a custom folder or URL."

This _should_ restore profiles, custom color themes as well as window arrangements.
