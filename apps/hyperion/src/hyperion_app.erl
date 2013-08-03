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
   {ok, Sup} = hyperion_sup:start_link(),
   expand_code_path(),
   {ok, Sup}.

stop(_State) ->
   ok.

%%
%% expand relative code path
expand_code_path() ->
	lists:foreach(fun expand_code_path/1, code:get_path()).

expand_code_path(Path) ->
	case filename:pathtype(Path) of
		relative ->
			code:del_path(Path),
			lists:foreach(
				fun(X) -> code:add_path(X) end,
				filelib:wildcard(filename:join([code:lib_dir(), Path]))
			);
		_        ->
			ok
	end.
