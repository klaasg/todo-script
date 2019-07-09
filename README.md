# A script that handles ToDo

The script will save to a todo file,  `~/.todo`. This is a tab seperated file with two columns: one for the time added and one for the actual thing to do.
For example:
```
01/01/19    make a todo script
02/02/19    study
```
The actual time format is still to be determined, options are a standard form like DD/MM/YY or unix epoch time.


How this script should behave:
* no arguments: display everything todo
* first argument is `add`: add other of arguments to todo
* first argument is `remove`: for each of the arguments after remove, remove all entries containing that word, with conformation
* first argument is something else: display todo but filtered on those words
