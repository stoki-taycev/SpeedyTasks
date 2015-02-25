require 'rails_helper'

RSpec.describe Task, :type => :model do

  it "should have a Title to be created" do
    @task = Task.create(:title => '')
    @task.valid?
    expect(@task.errors).to have_key(:title)
  end

  it "should retrieve users from database as an Array" do
    @task = Task.create(:title => 'Shared task', :owners => ['batman', 'superman', 'spiderman'])
    @task.reload
    expect(@task.owners.kind_of?(Array)).to eq(true)
  end

  it "should have many users" do
    @task = Task.create(:title => 'RSpec Task1')
    @user1 = User.create(:email => 'user1@user.com', :password => '12345678')
    @user2 = User.create(:email => 'user2@user.com', :password => '12345678')
    @user3 = User.create(:email => 'user3@user.com', :password => '12345678')

    @task.users << @user1
    @task.users << @user2
    @task.users << @user3

    expect(@task.users.size).to eq(3)

    expect(@task.users.first(3)).to eq([@user1, @user2, @user3])

    expect(@user1.tasks.first).to eq(@task)
    expect(@user2.tasks.first).to eq(@task)
    expect(@user3.tasks.first).to eq(@task)
  end


end
