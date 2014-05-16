require 'sinatra'
require 'idobata'
require 'json'

post '/' do
  push = JSON.parse(params[:payload])
  message = "[#{push['status']}] #{push['title']} <a href='#{push['commit_url']}' target='_black'>#{push['message']}</a> <a href='#{push['compare_url']}' target='_blank'>Compare</a>"
  Idobata.hook_url = ENV['IDOBATA_HOOK_URL']
  Idobata::Message.create(source: message, format: :html)
end