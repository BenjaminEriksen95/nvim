![vim is hard](vim-is-hard.png)

# Agenda


- Integrated Development Environments
- Vim bindings
- Built-in vim features
- Install neovim + :Tutor


# Integrated Development Enviroments(IDE)
Basically code editor with a bunch of nice features.

- How many are programming daily?
- What editor do people use? (VSCode, JetBrains variant, vim variant, other?)
- What amount of the features are you actually using?
- How fast are you at using them? (did you learn the shortcut?)


# Why do we use an IDE?
- Write code
- Read/Navigate code
- Edit code
- *Run code*
- *Debug code*

# How vim bindings could change how you interface with code.
1. Increase skill cap. Vim bindings are made for navigating and editing code faster.
2. Have more fun! Tinkering a macro or regex search replace can give you that Jedi mind trick experience.

# Vim bindings
Default typing has 1 mode: insertion(writing), and uses arrows/mouse for navigation.
Vim uses 4 modes:
- Normal (navigation)
    1. &#8592; &#8593; &#8594; &#8595; `h` `j` `k` `l`
    2. Navigate word `w` `e` `b` and WORD `W` `E` `B`
    3. Goto _ `f` `F` `t` `T`
    4. Repeat `;`, Reverse `,`
- Insert (writing)
- Visual (marking)
    - Same as navigation but with marking.
- Command-line (\inf)
    1. Exit `:q`
    2. Search `/`
    3. Replace `:s%/wrong/right/gc`
    4. Terminal stuff `:git pull`


# Built-in vim features

## Windows
`C-w`
- `C-w + s` - split horizontal.
- `C-w + v` - split vertical.

## Stacked bindings
Using several modes allows reusing key behavior for several purposes
- Mark inside ( - `vi(`
- Copy inside ( - `yi(`
- Move 5 lines down - `5j`

## Leader key
Leader key is used as a prefix to access commands.
`Space`

## Registers
`"`

## Macros
`q`


# Install neovim and run :Tutor
What we will use to practice vim-bindings today.


