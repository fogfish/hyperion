-module(echo).

-export([start/0]).

%%
%% start application
start() -> 
   applib:boot(?MODULE, "").
