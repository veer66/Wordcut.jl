function read_plain_dict(path)
    f = open(path)
    lines = readlines(f)
    close(f)
    words = sort(map(strip, lines))    
    items = map((word) -> (word,true), words)
    return make_prefix_tree(items)
end
