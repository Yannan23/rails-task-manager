class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    show_completed
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(@task)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def show_completed
    if @task.completed == true
      @show_completed = 'This task is completed'
    elsif @task.completed == false
      @show_completed = 'This task is not completed yet'
    end
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
