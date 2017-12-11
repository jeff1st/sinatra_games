require 'sinatra'
require 'sinatra/reloader'
require './ai'

enable :sessions
game = GameIA.new
results = []

get '/welcome' do
  erb :mastermind, { layout: :layout }
end

get '/game' do
  session[:secret] = game.secret
  res = game.results
  puts res.inspect
  session[:secret] << res
  results << session[:secret]
  erb :game, { layout: :layout,
                 :locals => {
                    :results => results
                 }
               }
end

