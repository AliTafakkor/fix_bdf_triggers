# fix_bdf_triggers
Small project to offset EEG event triggers to actual time of stimulus presentation for data recorded by BioSemi and Cedrus Stimtracker. 

### How to use:
Call `correct_triggers` function on *.bdf* file path, and it will generate another *.bdf* file with the same name and a *'corrected_'* prefix. You can use the function from shell:

`matlab -batch "correct_triggers('/path/to/file')"`

You can run `correct_all_files` script to automatically process all *.bdf* files in the current directory.

### Dependencies:
- eeglab: https://github.com/sccn/eeglab
- biosig (eeglab plug-in): https://github.com/donnchadh/biosig
