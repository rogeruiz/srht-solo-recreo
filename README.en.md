# Just recess

The repository `solo-recreo` is a lab for the `just` CLI tool. The examples and
scripts here are different ways to configure projects using `just` for a variety
of cases. Some examples follow:

- Creating new files for documentation types like decisions (ADR), run books,
  and more using templates or patterns.
- Using a programming language for recipes that use script files written in
  files separate from the `just` files.
- Various examples of do-nothing scripts that establish best-practices for
  automation that is not automated yet and can be further automated gradually.
  [Read more about this here][do-nothing].
- Have a way to know if a certain application is installed and can be found in
  the path variable, `$PATH`, in the terminal.

This project follows the most recent version of `just`: [1.39.0](https://github.com/casey/just/releases/tag/1.39.0)

## Architecture

This repository can be used as an live-example for how to organize files and
recipes for a mature project that utilizes `just`.

The `just` recipes are written like: `just <recipe> [arguments]`.

The directory `.justscripts/` is used to organize and separate the files that
you can create to extend `just` functionality using modules to create
sub-commands. This helps in separating recipes in practical ways.

This kind of recipe is written like: `just <module> <recipe> [arguments]`.

### Folders inside of `.justscripts/`

Inside this folder, you can organize things any way you want. I recommend
putting all scripts inside of folders named after the programming language. That
way scripts written for Node.js are placed inside of `js/`. With this kind of
separation, the `just` recipes and the JavaScript scripts are stored in their
appropriate file. Something to have in mind, variables that are set from `just`
need to be defined before the script file is read into the recipe. [Read more
about shebangs](#shebang-recipes).

### Shebang recipes

For the language folders in `.justscripts/`, the scripts here can be read into
`just` recipes using the `read()` function added in version `1.39.0`. This
allows for easy authoring of scripts in the language they're being written in.
The actual shebang line for the shebang recipes is written within the `just`
recipe along with any variable definitions that the shebang script is expecting.

This technique is what current powers the following recipes in this project.

- `just new decisions "Title for ADR document"`
- `just new run-books "Title for run book document"`
- `just new guides "Title for guide document"`

This kind of abstraction can be used for recipes that are going to be re-used
and mostly need a way to configure options for the recipe run.

### Do-nothing recipes

The do-nothing recipes are inspired by [Dan Slimmon's essay about the
topic][do-nothing]. Using private recipes, `[private]`, you can combine multiple
recipes into a series of steps. This kind of recipe makes it so you can start
automation processes without the actual automated steps. With do-nothing
scripts, you can minimize the time it takes to document and deploy processes on
your team. You can also iterate quickly on certain parts of your automation
while the commands stay the same in documentation and run books.

Run this command in your terminal to try it out.

```sh
just run-book setup-user "a_user_name"
```

Notice that with the private recipes this example calls you can replace other
commands piece by piece with other commands that `just` supports.

### Verifying that something is installed

With any recipe that uses other tools, it's important to verify that those tools
are installed in the user's path, `$PATH`, in their terminal. The `check` module
and `cli` recipe help by checking if something is installed. If it is not
installed, it will take the second argument to the `cli` recipe and provide a
link to download the missing tool.

Run this command in your terminal to try it. Change the string `"zsh"` to some
program that doesn't exist in the path so it can fail. Make sure to update the
second argument to provide download instructions for users that don't have the
tool installed.

```sh
just check cli "zsh" "https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#macos"
```

[do-nothing]: https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/
