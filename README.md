# A script that handles ToDo

#### This small project is considered almost done, except for small changes or improvements. You can suggest anything to add or improve!

The script saves a todo file, `~/.todo`. This is a tab seperated file with two columns: one for the time added and one for the actual thing to do.
For example:
```
01/01/19 00:00    make a todo script
02/02/19 15:42    study
```

## How this script should behave:
* no arguments: display everything todo
* first argument is `add`: add other of arguments to todo
* first argument is `remove`: for each of the arguments after remove, remove all entries containing that word, with conformation
* first argument is something else: display todo but filtered on arguments

## Current state of implementation:
Everything below should work properly.
```
$ todo.sh --help
usage:  todo.sh [ -t ] [ arg ... ]"
            List all todo's that match with args
        todo.sh add|-a|--add [ arg ... ]
            Add all todo's with name 'arg'
        todo.sh remove|-r|--remove [ -t ] [ arg ... ]
            Remove, with confirmation, all todo's that match with arg

        When matching, no arguments match all todo's
        Options:
            -t:     Display when todo was added.
```
The `-t` option should always come after `remove|--remove|-r`, because mostly lazyness
