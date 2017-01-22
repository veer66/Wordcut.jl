type PatEdgeBuilder
    s::Int
    e::Int
    pat_check
    edge_type::EdgeType
end

function create_pat_edge_builder(pat_check, edge_type::EdgeType)
    PatEdgeBuilder(0,0,pat_check, edge_type)
end

function build(builder::PatEdgeBuilder, context::EdgeBuildingContext) :: Nullable{Edge}
    
    if builder.s == 0
        if builder.pat_check(context.ch)
            builder.s = context.i
        end
    end

    if builder.s > 0
        if builder.pat_check(context.ch)
            if length(context.text) == context.i ||
                !builder.pat_check(
                    context.text[
                        chr2ind(context.text,
                                context.i + 1)])
               builder.e = context.i
            end
        else
            builder.s = 0
            builder.e = 0
        end
    end
    #println("CONTEXT = $context")
    #println("BUILDER = $builder")
    #println()
    return if builder.s > 0 && builder.e > 0
        source = context.path[builder.s]
        Edge(builder.s, builder.edge_type, source.w + 1, source.unk)
    else
        nothing
    end
end
