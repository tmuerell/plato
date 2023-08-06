require "rails_helper"

RSpec.describe UserProjectRolesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_project_roles").to route_to("user_project_roles#index")
    end

    it "routes to #new" do
      expect(get: "/user_project_roles/new").to route_to("user_project_roles#new")
    end

    it "routes to #show" do
      expect(get: "/user_project_roles/1").to route_to("user_project_roles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_project_roles/1/edit").to route_to("user_project_roles#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_project_roles").to route_to("user_project_roles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_project_roles/1").to route_to("user_project_roles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_project_roles/1").to route_to("user_project_roles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_project_roles/1").to route_to("user_project_roles#destroy", id: "1")
    end
  end
end
