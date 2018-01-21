%% 
%% @doc
%%
-module(echo_restapi).
-compile({parse_transform, category}).

-export([endpoints/0]).

%%
%%
endpoints() ->
   [
      ipaddr_json()
   ].


%%
%% Returns Origin IP.
%%
ipaddr_json() ->
   [reader ||
      _ /= restd:path("/"),
      _ /= restd:method('GET'),
      _ /= restd:provided_content({application, json}),
      Peer /= restd:header(<<"X-Knet-Peer">>),
      _ /= restd:to_json({ok, #{ip => Peer}})
   ].
