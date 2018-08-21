%%
%%   Copyright (c) 2012 - 2013, Dmitry Kolesnikov
%%   All Rights Reserved.
%%
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%
%%       http://www.apache.org/licenses/LICENSE-2.0
%%
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%
%%  @description
%%
-module(hyperion_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
   ok = add_code_path([
      "_build/default/lib/*/ebin/*.app",
      "/usr/local/otp/lib/erlang/lib/*/ebin/*.app"
   ]),
   ok = expand_code_path(),
   ok = start_app(appname()),
   hyperion_sup:start_link().


stop(_State) ->
   ok.

%%
%% inject custom code path
add_code_path([H|List]) ->
   lists:foreach(
      fun(X) ->
         code:add_patha(filename:dirname(X))
      end,
      findlib(H)
   ),
   add_code_path(List);

add_code_path([]) ->
   ok.

%%
%% expand relative code path to absolute one
expand_code_path() ->
	lists:foreach(fun expand_code_path/1, code:get_path()).

expand_code_path(Path) ->
	case filename:pathtype(Path) of
		relative ->
			code:del_path(Path),
			lists:foreach(
				fun(X) -> 
               code:add_path(X) 
            end,
				filelib:wildcard(filename:join([code:lib_dir(), Path]))
			);
		_        ->
			ok
	end.

%%
%% external libdir
libdir() ->
   application:get_env(hyperion, libdir, "/tmp/hyperion").

%%
%%
appname() ->
   erlang:list_to_atom(os:getenv("SPAWN", "undefined")).

%%
%%
findlib(Path) ->
   filelib:wildcard(filename:join([libdir(), Path])).

%%
%%
start_app(undefined) ->
   error_logger:warning_report([{application, undefined}]),
   ok;
start_app(AppName) ->
   error_logger:info_report([{application, AppName}]),
   {ok, _} = application:ensure_all_started(AppName, permanent),
   ok.

