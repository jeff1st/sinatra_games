require 'sinatra'
require 'sinatra/reloader'
require './ai'
require './cipher'

include Cipher

enable :sessions
game = GameIA.new

def check_message(remains, result)
  message = ""

  if result == ["O", "O", "O", "O"]
    message = "Wonderful!, you found it!"

  elsif result != ["O", "O", "O", "O"] && remains == 0
    message = "Wow, too bad, not found!"

  else
    message = "Only #{remains} attempt(s) left!"
  end

  return message
end

def keep_last_selection(res)
  transform = []
  colors = ["yellow", "blue", "red", "green", "pink", "orange"]
  (0...4).each { |i| transform[i] = colors.index(res[i])+1 }
  return transform
end

def set_message(message, shift = 3)
  return nil if (message == nil || message == "")
  return Cipher::cipher(message, shift)
end

get '/' do
  direction = params[:name]
  if !direction.nil?
    if direction == "cipher"
      redirect '/cipher'
    else 
      redirect '/game'
    end
  end

  erb :welcome, { :layout => :layout }
end

get '/game' do
  session[:results] ||= []
  sel ||= []

  if params[:field1]
    game.guess = [params[:field1], params[:field2], params[:field3], params[:field4]]
    game.check_guess

    session[:results] << (game.guess << game.results)

    game.reduce

    message = check_message(game.attempts, game.results)
    remains = game.attempts
    res = game.results
    sel = keep_last_selection(session[:results][-1])
  end

  erb :game, { :layout => :layout,
                 :locals => {
                    :message => message,
                    :results => session[:results],
                    :res => res,
                    :remains => remains,
                    :sel => sel
                 }
               }
end

get '/reset' do
  session[:results] = []
  game = GameIA.new
  redirect '/game'
end

get '/cipher' do
  name = ""
  shift = params[:shift].to_i
  message = set_message(params[:message], shift)
  erb :cipher, { :layout => :layout,
                 :locals => {
                     :name => name,
                     :message => message,
                     :shift => shift
                 }
               }
end

