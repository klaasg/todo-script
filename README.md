# A script that handles ToDo

### This simple script supports adding, viewing and removing todo's!

This small project is considered (almost) done, except for small changes or improvements. You can suggest anything to add or improve!

## Current state of implementation:
Sample output:
```
$ todo add "Work on project" "Commit project" "Go to sleep"
Adding Work on project
Adding Commit project
Adding Go to sleep
$ todo project
2 matche(s) found
	Work on project
	Commit project
$ todo -r sleep
1 matche(s) found
	Go to sleep
	Do you want to delete this todo? [Y/n] y
$ todo -t
	13/07/2019 20:50:	Work on project
	13/07/2019 20:50:	Commit project
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
Everything in the usage should be implemented properly.
The `-t` option should always come after `remove|--remove|-r`, mostly because of lazyness

## Info on implementation:
The script saves a file, `~/.todo`. This is a tab seperated file with two columns: one for the time added and one for the actual thing to do.
For example:
```
01/01/19 00:00    make a todo script
02/02/19 15:42    study
```

