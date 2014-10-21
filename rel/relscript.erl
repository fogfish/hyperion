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
   
   %% copy libraries
   RootDir      = rebar_rel_utils:get_root_dir(RelCfg),
   io:format("====> ~p~n", [RootDir]),

	lists:foreach(
		fun(X) -> ok = copy_lib(Release, RootDir, X) end,
		proplists:get_value(lib, RelCfg, [])
	),
   copy_bin(Release, RootDir, erlc).

%%
copy_lib(Rel, RootDir, Lib) ->
   Libs = lists:reverse(
      filelib:wildcard(
         filename:join([RootDir, "lib", atom_to_list(Lib) ++ "-*"])
      )
   ),
	case Libs of
		[] ->
			ok;
		[Src|_] ->
			io:format("==> rel copy: ~p~n", [Src]),
			Dst = filename:join([rebar_utils:get_cwd(), Rel, "lib", filename:basename(Src)]),
			os:cmd(lists:flatten(io_lib:format("cp -R ~s ~s", [Src, Dst]))),
			ok
	end.

%%
copy_bin(Rel, RootDir, Bin) ->
   io:format("==> rel copy: ~p~n", [Bin]),
   Src = filename:join([RootDir, "bin", Bin]),
   Dst = filename:join([rebar_utils:get_cwd(), Rel, "bin", Bin]),
   os:cmd(lists:flatten(io_lib:format("cp -R ~s ~s", [Src, Dst]))),
   ok.
