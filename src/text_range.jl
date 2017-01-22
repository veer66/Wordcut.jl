type TextRange
    s
    e
end

function to_token(text_range::TextRange, text::String)
    s = chr2ind(text, text_range.s)
    e = chr2ind(text, text_range.e)
    text[s:e]
end

function to_tokens(text_ranges::Array{TextRange,1}, text::String) ::Array{String,1}
    map((r) -> to_token(r, text), text_ranges)
end
