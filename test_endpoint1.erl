-module(test_endpoint1).

-include_lib("nitro/include/nitro.hrl").

-compile(export_all).

main()->
    #dtl{file = "test_endpoint", app = web,
         bindings = [{body, body()}]}.

body()->
    ["Test endpoint 1",
    #button{postback=button_click1, body=["Button click 1 event"]}].

event(init)->
    io:format("~n ~p, ~p: ~p ~n~n", [?MODULE, init, event]);

event(button_click1)->
    wf:wire(#alert{text="test_endpoint1 button clicked"}),
    io:format("~n ~p, ~p: ~p ~n~n", [?MODULE, button_click, event]);

event(load_content)->
    wf:update(content, test_endpoint:body()).
