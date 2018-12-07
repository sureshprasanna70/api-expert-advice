Doorkeeper::Application.destroy_all
Doorkeeper::Application.create(name: "starter_project_web", redirect_uri: "http://localhost:3000/")
