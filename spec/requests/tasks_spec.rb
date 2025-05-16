require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  include Warden::Test::Helpers

  let(:user) { User.create(email: "test@example.com", password: "password") }
  let!(:task) { Task.create(title: "Test Task", user: user, priority: :medium) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /tasks" do
    it "returns a success response" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /tasks/:id" do
    it "shows the task" do
      get task_path(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /tasks/new" do
    it "renders the new template" do
      get new_task_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /tasks/:id/edit" do
    it "renders the edit template" do
      get edit_task_path(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /tasks" do
    it "creates a task and redirects" do
      expect {
        post tasks_path, params: {
          task: {
            title: "Nova Tarefa",
            status: "to_do",
            priority: "medium"
          }
        }
      }.to change(Task, :count).by(1)

      expect(response).to redirect_to(assigns(:task))
    end
  end

  describe "PATCH /tasks/:id" do
    it "updates the task" do
      patch task_path(task), params: {
        task: {
          title: "Atualizada"
        }
      }
      expect(response).to redirect_to(task)
      expect(task.reload.title).to eq("Atualizada")
    end
  end

  describe "DELETE /tasks/:id" do
    it "deletes the task" do
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_path)
    end
  end

  describe "PUT /task/:id/move_to_column" do
    it "altera o status da task" do
      put "/task/#{task.id}/move_to_column", params: { status: "done" }
      expect(response).to have_http_status(:success)
      expect(task.reload.status).to eq("done")
    end
  end
end
