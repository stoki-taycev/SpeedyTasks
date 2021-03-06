class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner, only: [:show, :edit, :go_share]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @tasks = Task.all
    @new_task = Task.new
    @users = User.all
    respond_to do |format|
      format.html { render :action => 'index' }
      format.js {render :action => "index.js.erb"}
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.owners.push(current_user.email)
      @task.save
      @task.add_user current_user
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  def go_share
    @task = Task.find(params[:id])
    @users = User.all
  end

  def share
    @users = User.all
    @task = Task.find(params[:id])
    if @task.owners.include?(params[:task][:owners])
      redirect_to tasks_path
      return
    else
      @task.owners.push(params[:task][:owners])
      @task.save
      @task.add_user @users.find_by(:email => (params[:task][:owners]))
      redirect_to tasks_path
      return
    end
  end



  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :owners)
  end

  def check_owner
    @task = Task.find(params[:id])
    if @task.owners.include?(current_user.email.to_s)
      return true
    else
      redirect_to tasks_path
      return
    end
  end

  def record_not_found
    redirect_to tasks_path
  end

end
