class TasksController < ApplicationController

  def index
    tasks = Task.all

    respond_to do |f|
      f.html do
        render template: 'tasks/index.html.erb', locals: {all_tasks: tasks }
      end
      f.json do
        render json: tasks.to_json, status: 200
      end
    end
  end

  def new
    task = Task.new
    render json: task.to_json, status: 200
  end

  def show
    # render text: "params : #{params.inspect}"
    if Task.exists?(params[:id])
      task = Task.find(params[:id])
      respond_to do |f|
      f.html do
        render template: 'tasks/show.html.erb', locals: { one_task: task }
      end
      f.json do
        render json: tasks.to_json, status: 200
      end
    end
    else
      render html: 'Record Not Found!', status: 404
    end
  end

  #edit would go here

  def create
    #For create to work, we must *require* that a parameter is sent with the name 'task'
    if params[:task].empty?
      err_msg = "The 'task' parameter was empty or not found"
      render json: { error_msg: err_msg }.to_json, status: 422
    else
      task = Task.new
      task.task = params[:task]
      task.save!
      render json: task
    end
  end

  def update
    if Task.exists?(params[:id])
      task = Task.find(params[:id])
      task.completed  = params[:completed]
      task.save
      render json: task, status: 200
    end
  end

  def destroy
    if Task.exists?(params[:id])
      task = Task.find(params[:id])
      task.destroy
      message = "Task #{task} was deleted."
      render json: message, status: 200
    end
  end

end
