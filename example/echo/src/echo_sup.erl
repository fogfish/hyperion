%%
%%
-module(echo_sup).
-behaviour(supervisor).

-export([
   start_link/0, 
   init/1
]).

%%
-define(CHILD(Type, I),            {I,  {I, start_link,   []}, permanent, 5000, Type, dynamic}).
-define(CHILD(Type, I, Args),      {I,  {I, start_link, Args}, permanent, 5000, Type, dynamic}).
-define(CHILD(Type, ID, I, Args),  {ID, {I, start_link, Args}, permanent, 5000, Type, dynamic}).

%%
%%
start_link() ->
   supervisor:start_link({local, ?MODULE}, ?MODULE, []).
   
init([]) -> 
   {ok,
      {
         {one_for_one, 4, 1800},
         [
            restapi()
         ]
      }
   }.

%%
%%
restapi() ->
   restd:spec(
      echo_restapi:endpoints(), 
      [{port, "http://*:8888"}, {backlog, 1024}]
   ).
