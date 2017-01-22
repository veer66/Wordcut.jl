function build_path(edge_builders, text::String) ::Array{Edge,1}
    context = EdgeBuildingContext(text,
                                  Array{Edge}(length(text) + 1),
                                  '\0',
                                  1,
                                  1,
                                  nothing)
    context.path[1] = Edge(0, init, 0, 0)
    for ch in text
        context.best_edge = nothing
        context.ch = ch
        for edge_builder in edge_builders
            edge = build(edge_builder, context)
            if is_better_than(edge, context.best_edge)
                context.best_edge = edge
            end
        end
        @assert !isnull(context.best_edge)
        context.path[context.i + 1] = get(context.best_edge)
        if !is_unk(get(context.best_edge))
            context.left_boundary = context.i + 1
        end
        context.i += 1
    end
    return context.path
end
