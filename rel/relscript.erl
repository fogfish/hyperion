%% @description
%%   copies c- and j- node interfaces to final release 
-module(relscript).

-export([
	post_generate/2
]).

post_generate(_, undefined) ->
   ok;
post_generate(Config, File) ->
	case filename:basename(File) of
		"reltool.config" ->
			reltool(Config, File);
		_ ->
			ok
	end.

%%
%% handle release
reltool(Config, File) ->
	Release = filename:basename(
		filename:dirname(
			rebar_utils:get_cwd()
		)
	),

	{ok, RelCfg} = file:consult(File),
	lists:foreach(
		fun(X) -> ok = copy_lib(Release, X) end,
		proplists:get_value(lib, RelCfg, [])
	).

%%
copy_lib(Rel, Lib) ->
	case code:lib_dir(Lib) of
		{error, bad_name} ->
			ok;
		Src ->
			io:format("==> rel copy: ~p~n", [Lib]),
			Dst = filename:join([rebar_utils:get_cwd(), Rel, "lib", filename:basename(Src)]),
			os:cmd(lists:flatten(io_lib:format("cp -R ~s ~s", [Src, Dst]))),
			ok
	end.