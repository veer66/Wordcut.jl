function check_punc(ch::Char) :: Bool
    ch == ' '
end

function create_punc_edge_builder()
    create_pat_edge_builder(check_punc, punc)
end
