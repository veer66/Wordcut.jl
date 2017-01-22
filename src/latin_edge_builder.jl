function check_latin(ch::Char) :: Bool
    (ch >= 'A' && ch <= 'Z') ||
        (ch >= 'a' && ch <= 'z')
end

function create_latin_edge_builder()
    create_pat_edge_builder(check_latin, latin)
end
