type PrefixTree
    tab::Dict{Tuple{Int32,Int32,Char},Tuple{Int32,Bool,Any}}
end

function make_prefix_tree(sorted_word_with_payload)
    tab = Dict{Tuple{Int32,Int32,Char},Tuple{Int32,Bool,Any}}()
    for i in 1:length(sorted_word_with_payload)
        word, payload = sorted_word_with_payload[i]
        row_no = 1
        j = 1
        for word_idx in eachindex(word)
            ch = word[word_idx]
            key = (row_no, j, ch)
            is_final = length(word) == j
            if haskey(tab, key)
                child_id, _, _ = tab[key]
                row_no = child_id
            else
                tab[key] = (i, is_final, is_final ? payload : nothing)
                row_no = i
            end
            j += 1
        end
    end
    PrefixTree(tab)
end

function lookup(tree::PrefixTree, node_id, offset, ch::Char) :: Nullable{Tuple{Int32,Bool,Any}}
    key = (Int32(node_id), Int32(offset), ch)
    if haskey(tree.tab, key)
        return tree.tab[key]
    else
        return nothing
    end
end
