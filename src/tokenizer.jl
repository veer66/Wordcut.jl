type Tokenizer
    edge_builder_factories
end

function create_tokenizer(tree::PrefixTree) ::Tokenizer
    factories = [() -> create_dict_edge_builder(tree),
                 () -> create_latin_edge_builder(),
                 () -> create_punc_edge_builder(),
                 () -> UnkEdgeBuilder()]
    Tokenizer(factories)
end

function path_to_text_ranges(path)::Array{TextRange,1}
    text_ranges = []
    i = length(path)
    while i > 1
        edge = path[i]
        s = edge.p
        e = i - 1
        push!(text_ranges, TextRange(s, e))
        i = s
    end
    reverse(text_ranges)
end

function tokenize(tokenizer::Tokenizer, text::String)::Array{String,1}
    edge_builders = map((create) -> create(),
                          tokenizer.edge_builder_factories)
    path = build_path(edge_builders, text)
    text_ranges = path_to_text_ranges(path)
    to_tokens(text_ranges, text)
end
