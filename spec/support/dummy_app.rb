require 'sinatra'

class DummyApp < Sinatra::Application
  get '/' do
    'homepage'
  end

  get '/inner-page' do
    'inner page'
  end

  post '/' do
    'homepage with post'
  end

  put '/' do
    'homepage with put'
  end

  delete '/' do
    'homepage with delete'
  end
end
