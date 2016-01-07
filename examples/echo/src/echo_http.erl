%%
%%   Copyright (c) 2016, Dmitry Kolesnikov
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
-module(echo_http).
-behaviour(pipe).

-export([
   start_link/2,
   init/1,
   free/2,
   handle/3
]).


%%
%%
start_link(Uri, Opts) ->
   pipe:start_link(?MODULE, [Uri, Opts], []).

init([Uri, Opts]) ->
   {ok, handle, knet:bind(Uri, Opts)}.

free(_, Sock) ->
   knet:close(Sock).

%%
%%
handle({http, _Sock, {_Mthd, _Url, _Head, _Env}}, Pipe, Sock) ->
   _ = pipe:a(Pipe, {ok, [
      {'Server',              <<"echo">>},
      {'Transfer-Encoding',   <<"chunked">>},
      {'Connection',          <<"keep-alive">>}
   ]}),
   {next_state, handle, Sock};

handle({http, _Sock, eof}, Pipe, Sock) ->
   pipe:a(Pipe, eof),
   {next_state, handle, Sock};

handle({http, _Sock, Msg}, Pipe, Sock) ->
   pipe:a(Pipe, Msg),
   {next_state, handle, Sock}.
