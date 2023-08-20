require "rails_helper"

RSpec.describe TagGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tag_groups").to route_to("tag_groups#index")
    end

    it "routes to #new" do
      expect(get: "/tag_groups/new").to route_to("tag_groups#new")
    end

    it "routes to #show" do
      expect(get: "/tag_groups/1").to route_to("tag_groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tag_groups/1/edit").to route_to("tag_groups#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tag_groups").to route_to("tag_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tag_groups/1").to route_to("tag_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tag_groups/1").to route_to("tag_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tag_groups/1").to route_to("tag_groups#destroy", id: "1")
    end
  end
end
