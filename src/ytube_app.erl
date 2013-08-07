-module(ytube_app).
-author("shree@ybrantdigital.com").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_',[
				{"/api/home", site_root_handler, []},
				{"/api/videos/featured_nyt", videos_nyt_featured_handler, []},
                {"/api/videos/featured_wsj", videos_wsj_featured_handler, []},
                {"/api/videos/featured_cbs", videos_cbs_featured_handler, []},
                {"/api/videos/home_video", videos_home_video_handler, []}, 
				{"/api/videos/popular", videos_popular_handler, []},
				{"/api/videos/most_watched", videos_most_watched_handler, []},
				{"/api/videos/top_rated", videos_top_rated_handler, []},
                {<<"/v/:id">>, video_page_handler, []},
				{"/css/[...]", cowboy_static, 
					[
                		{directory, {priv_dir, ytube, ["public/css"]}},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	},
                {"/fonts/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, ytube, ["public/fonts"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
                {"/images/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, ytube, ["public/images"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
                {"/thumbs/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, ytube, ["public/thumbs"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
            	{"/js/[...]", cowboy_static, 
            		[
                		{directory, {priv_dir, ytube, ["public/js"]}},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	},
            	{"/videos/[...]", cowboy_static, 
            		[
                		{directory, {priv_dir, ytube, ["public/videos"]}},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	},
                {"/players/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, ytube, ["public/players"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
            	{"/", cowboy_static, 
            		[
                		{directory, {priv_dir, ytube, ["public"]}},
                		{file, "home.html"},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	}
                
			 ]
		}

	]), 
    ok = application:start(lager),
    ok = application:start(crypto),
    ok = application:start(jsx),
    ok = application:start(ranch),
    ok = application:start(cowboy),
    ok = application:start(ibrowse),
    %ok = application:start(ytube),

	{ok, _} = cowboy:start_http(http,100, [{port, 8899}],[{env, [{dispatch, Dispatch}]}]), 
    ytube_sup:start_link().

stop(_State) ->
    ok.
