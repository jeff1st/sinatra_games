require 'sinatra'
require 'sinatra/reloader'

enable :sessions
RESULTS = [["blue", "red", "green", "blue", [".", "o", "x", "."]],
           ["red", "red", "blue", "green", ["x", "o", ".", "o"]],
           ["green", "red", "yellow", "purple", [".", "o", "o", "."]],
           ["red", "yellow", "orange", "green", ["o", ".", "x", "o"]],
           ["purple", "red", "orange", "blue", ["x", "o", ".", "x"]],
           ["red", "orange", "purple", "green", [".", "x", "x", "."]]
]

get '/welcome' do
  erb :mastermind, { layout: :layout }
end

get '/game' do
  puts params[:player]
  if params[:player] != ""
    session[:player] = params[:player]
    erb :game, { layout: :layout,
                       :locals => {
                          :session => session,
                          :results => RESULTS
                       }
                     }
  else
    render '/welcome'
  end
end

