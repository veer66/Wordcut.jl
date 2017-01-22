using wordcut
using Base.Test

###################### prefix-tree ###########################

tree = wordcut.make_prefix_tree([("A", 10)])
@test get(wordcut.lookup(tree, 1, 1, 'A')) == (1, true, 10)
@test isnull(wordcut.lookup(tree, 1, 1, 'B'))

tree = wordcut.make_prefix_tree([("AB", 20)])
@test get(wordcut.lookup(tree, 1, 1, 'A')) == (1, false, nothing)
@test get(wordcut.lookup(tree, 1, 2, 'B')) == (1, true, 20)

tree = wordcut.make_prefix_tree([("ก", 10), ("กข", 20)])
@test get(wordcut.lookup(tree, 1, 1, 'ก')) == (1, true, 10)
@test get(wordcut.lookup(tree, 1, 2, 'ข')) == (2, true, 20)


####################### tokenizer ###########################

tree = wordcut.make_prefix_tree([("กา", 10), ("กาม", 20)])
tokenizer = wordcut.create_tokenizer(tree)
@test wordcut.tokenize(tokenizer, "กามกา") == ["กาม", "กา"]
@test wordcut.tokenize(tokenizer, "กากา") == ["กา", "กา"]

# space
@test wordcut.tokenize(tokenizer, "ขา ขา") == ["ขา", " ", "ขา"]

# latin
@test wordcut.tokenize(tokenizer, "ขาAbCขา") == ["ขา", "AbC", "ขา"]

###################### read dict ######################

tree = wordcut.read_plain_dict(joinpath(Pkg.dir("wordcut"), "test", "two.txt"))
@test get(wordcut.lookup(tree, 1, 1, 'ก')) == (1, false, nothing)
