-module(test_endpoint).

-include_lib("nitro/include/nitro.hrl").

-compile(export_all).

main()->
    #dtl{file = "test_endpoint", app = web,
         bindings = [{body, body()}]}.

body()->
    ["Test endpoint",
    #button{postback=button_click, body=["Button click event"]},
    #button{postback=load_content, body=["Load content"]}].

event(init)->
    io:format("~n ~p, ~p: ~p ~n~n", [?MODULE, init, event]);

event(button_click)->
    wf:wire(#alert{text="button clicked"}),
    io:format("~n ~p, ~p: ~p ~n~n", [?MODULE, button_click, event]);

event(load_content)->
    wf:update(content, test_endpoint1:body()),
    wf:wire("window.history.pushState('page2', 'Title', '/test_endpoint1');");
    % wf:wire("ws.close();");

event(E)->
    % test_endpoint1:event(E),
    io:format("~n ~p, ~p: ~p ~n~n", [?MODULE, unknown_event, E]).
