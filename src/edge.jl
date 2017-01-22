@enum EdgeType init=1 dict=2 unk=3 latin=4 punc=5

type Edge
    p
    edge_type::EdgeType
    w
    unk
end

function is_unk(edge::Edge)
    edge.edge_type == unk
end

function is_better_than(a::Edge, b::Edge) :: Bool
    if a.unk < b.unk
        return true
    end

    if a.unk > b.unk
        return false
    end

    if a.w < b.w
        return true
    end

    if a.w > b.w
        return false
    end

    if a.edge_type != unk && b.edge_type == unk
        return true
    end

    return false
end

function is_better_than(a::Nullable{Edge}, b::Nullable{Edge}) :: Bool
    if isnull(a)
        return false
    end

    if isnull(b)
        return true
    end
    
    is_better_than(get(a), get(b))
end
