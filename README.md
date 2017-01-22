# wordcut

wordcut.jl is a word tokenizer for ASEAN languages written in Julia


## Install

It has not been registered yet, so it has to be installed from source code?

## Example

````julia
import wordcut

tree = wordcut.read_plain_dict("/your-path/your-dict.txt")
tokenizer = wordcut.create_tokenizer(tree)

for line in readlines(STDIN)
    println(join(wordcut.tokenize(tokenizer, chomp(line)), "|"))
end
````
