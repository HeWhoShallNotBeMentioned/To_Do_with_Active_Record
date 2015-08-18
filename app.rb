require('sinatra')
require('sinatra/reloader')
require('./lib/list/')
require('./lib/task/')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "to_do_test"})

get '/' do
  @lists = List.all()
  erb(:index)
end

get('/list/:id') do

end

post('/lists/new') do
  name = params.fetch('name')
  list = List.new({:name => name, :id => nil})
  list.save()
  redirect('/')
end

post('/tasks/new') do
  description = params.fetch('description')
  due_date = params.fetch('due date')
  id = params.fetch('list id').to_i()
  @list = List.find(id)
  task = Task.new({:description => description, :due_date => due_date, :list_id => id})
  task.save()
  redirect('/list/' + id.to_s())
end
