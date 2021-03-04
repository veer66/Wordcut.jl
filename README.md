# wordcut

wordcut.jl is a word tokenizer for ASEAN languages written in Julia

## Installation

```
pkg> add https://github.com/veer66/wordcut.jl
```

## Example

### Get wordlist

```Shell
wget https://raw.githubusercontent.com/veer66/chamkho/master/data/thai.txt -o thai.txt
```

### In Julia

````julia
import Wordcut
dix = Wordcut.make_prefix_tree(map(w -> (w,Int32(1)), eachline(open("thai.txt"))))
Wordcut.tokenize(dix, "กากกา")
````

### Alternative
````julia
import Wordcut
dix = Wordcut.make_prefix_tree(map(w -> (w,Int32(1)), eachline(open("thai.txt"))))
Wordcut.tokenize(dix, "กากกา", "|")
````
