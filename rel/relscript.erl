%% @description
%%   copies c- and j- node interfaces to final release 
-module(relscript).

-export([
	post_generate/2
]).

post_generate(_, undefined) ->
   ok;
post_generate(Config, _) ->
	Node = filename:basename(
		filename:dirname(
			rebar_utils:get_cwd()
		)
	),
	ok = copy_lib(Node, erl_interface),
	ok = copy_lib(Node, jinterface).

copy_lib(Node, Name) ->
	case code:lib_dir(Name) of
		{error, bad_name} ->
			ok;
		Src ->
			Dst = filename:join([rebar_utils:get_cwd(), Node, "lib", filename:basename(Src)]),
			os:cmd(lists:flatten(io_lib:format("cp -R ~s ~s", [Src, Dst]))),
			ok
	end.