require 'sinatra'
require 'idobata'
require 'json'

post '/' do
  push = JSON.parse(params[:payload])
  case push['status']
  when 'pass'
    status_message = "<span class='label label-sucess>#{push['status'].upcase}</span>"
  when 'fail'
    status_message = "<span class='label label-important>#{push['status'].upcase}</span>"
  end
  message = "#{status_message} #{push['message']} by @#{push['committer']} <a href='#{push['commit_url']}' target='_black'>Commit</a> <a href='#{push['build_url']}' target='_blank'>Build</a>"
  Idobata.hook_url = ENV['IDOBATA_HOOK_URL']
  Idobata::Message.create(source: message, format: :html)
end