fun({Doc}) ->
    JSONKey = fun(Name, Plist) ->
        {Name, proplists:get_value(Name, Plist, null)}
    end,
    case proplists:get_value(<<"created_at">>, Doc) of
        undefined -> ok;
        CreatedAt ->
            case proplists:get_value(<<"profile">>, Doc) of
                undefined -> 
                    Emit(CreatedAt, {[
                        JSONKey(<<"message">>, Doc)
                    ]});
                {Profile} ->
                    Emit(CreatedAt, {[
                        JSONKey(<<"message">>, Doc),
                        JSONKey(<<"gravatar_url">>, Profile),
                        JSONKey(<<"nickname">>, Profile),
                        JSONKey(<<"name">>, Profile)
                    ]})
            end
    end
end.
