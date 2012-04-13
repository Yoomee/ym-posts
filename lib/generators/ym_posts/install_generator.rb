module YmPosts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmPosts."

      def manifest
        copy_file "models/post.rb", "app/models/post.rb"
        copy_file "controllers/posts_controller.rb", "app/controllers/posts_controller.rb"
        copy_file "views/tags/show.html.haml", "app/views/tags/show.html.haml"
        copy_file "views/tags/show.js.erb", "app/views/tags/show.js.erb"

        if should_add_abilities?('Post')
          add_ability(:user, ["can [:read, :create], Post", "can [:update, :destroy], Post, :user_id => user.id"])
        end
        
        if File.exists?("#{Rails.root}/app/controllers/tags_controller.rb")
          insert_into_file "app/controllers/tags_controller.rb", "  expose(:posts) {Post.tagged_with(current_tag.name).page(params[:page])}\n", :after => "include YmTags::TagsController\n"
        end
        
        # Migrations must go last
        Dir[File.dirname(__FILE__) + '/templates/migrations/*.rb'].each do |file_path|
          file_name = file_path.split("/").last
          migration_template "migrations/#{file_name}", "db/migrate/#{file_name.sub(/^\d+\_/, '')}"
        end
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      private
      def should_add_abilities?(model_name)
        File.exists?("#{Rails.root}/app/models/ability.rb") && !File.open("#{Rails.root}/app/models/ability.rb").read.include?(model_name)
      end

      def add_ability(role, abilities)
        ability_string = [*abilities].join("\n      ")
        insert_into_file "app/models/ability.rb", "\n      #{ability_string}", :after => "#{role} ability"
      end
      
    end
  end
end
