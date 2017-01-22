type Pointer
    s :: Int
    node_id :: Int32
    offset :: Int
    is_final :: Bool
end

type DictEdgeBuilder
    tree
    pointers::Array{Pointer,1}
end

function create_dict_edge_builder(tree::PrefixTree)
    DictEdgeBuilder(tree, [])
end

function update(builder::DictEdgeBuilder, pointer::Pointer, ch::Char) :: Bool
    child = lookup(builder.tree, pointer.node_id, pointer.offset, ch)
    if isnull(child)
        return false
    end
    node_id, is_final, _ = get(child)
    pointer.offset += 1
    pointer.is_final = is_final
    pointer.node_id = node_id
    return true
end

function update(builder::DictEdgeBuilder, ch::Char)
    j = 1
    for i in 1:length(builder.pointers)
        if update(builder, builder.pointers[i], ch)
            if j < i
                builder.pointers[j] = builder.pointers[i]
            end
            j += 1
        end
    end
    resize!(builder.pointers, j-1)
end

function gen_edge(pointer::Pointer, path:: Array{Edge,1})
    source = path[pointer.s]
    Edge(pointer.s, dict, source.w + 1, source.unk)
end

function gen_edge(pointers::Array{Pointer,1}, path:: Array{Edge,1})
    best_edge::Nullable{Edge} = nothing
    for pointer in pointers
        if pointer.is_final
            edge = gen_edge(pointer, path)
            if isnull(best_edge) || is_better_than(edge, get(best_edge))
                best_edge = edge
            end
        end
    end
    return best_edge
end

function build(builder::DictEdgeBuilder, context::EdgeBuildingContext) :: Nullable{Edge}
    push!(builder.pointers, Pointer(context.i, 1, 1, false))
    update(builder, context.ch)
    return gen_edge(builder.pointers, context.path)
end
