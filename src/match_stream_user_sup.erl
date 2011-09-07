%%%-------------------------------------------------------------------
%%% @author Fernando Benavides <fernando.benavides@inakanetworks.com>
%%% @copyright (C) 2010 InakaLabs S.R.L.
%%% @doc Supervisor for User Processes
%%% @end
%%%-------------------------------------------------------------------
-module(match_stream_user_sup).

-behaviour(supervisor).

-export([start_link/0, start_client/0, init/1]).

%% ====================================================================
%% External functions
%% ====================================================================
%% @doc  Starts the supervisor process
-spec start_link() -> ignore | {error, term()} | {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @doc  Starts a new client process
-spec start_client() -> {ok, pid() | undefined} | {error, term()}.
start_client() ->
  supervisor:start_child(?MODULE, []).

%% ====================================================================
%% Server functions
%% ====================================================================
%% @hidden
-spec init([]) -> {ok, {{simple_one_for_one, 100, 1}, [supervisor:child_spec()]}}.
init([]) ->
    {ok, {{simple_one_for_one, 100, 1},
            [{match_stream_user, {match_stream_user, start_link, []},
              temporary, brutal_kill, worker, [match_stream_user]}]}}.