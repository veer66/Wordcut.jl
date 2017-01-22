type EdgeBuildingContext
    text ::String
    path ::Array{Edge,1}
    ch ::Char
    i ::Int
    left_boundary ::Int
    best_edge ::Nullable{Edge}
end
