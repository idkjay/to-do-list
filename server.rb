require "sinatra"
# require "pry"

set :bind, '0.0.0.0'  # bind to all interfaces
set :public_folder, File.join(File.dirname(__FILE__), "public")

get '/' do
  redirect '/tasks'
end

get "/tasks/:task_name" do
  @task_name = params[:task_name]
  erb :show
end

post "/tasks" do
  # binding.pry
  # Read the input from the form the user filled out
  task = params["task_name"]

  # Open the "tasks.txt" file and append the task
  File.open("tasks.txt", "a") do |file|
    file.puts(task)
  end

  # Send the user back to the home page which shows
  # the list of tasks
  redirect "/tasks"
end

get "/tasks" do
  @tasks = File.readlines("tasks.txt")
  erb :index
end
