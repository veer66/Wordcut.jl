type UnkEdgeBuilder
end

function build(builder::UnkEdgeBuilder, context::EdgeBuildingContext) :: Nullable{Edge}
    if !isnull(context.best_edge)
        return nothing
    end

    p = context.left_boundary
    source = context.path[p]
    Edge(p, unk, source.w + 1, source.unk + 1)
end

    
