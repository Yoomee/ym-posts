module YmPosts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmPosts."

      system("bundle exec rails generate ym_tags:install")
      system("bundle exec rails generate ym_users:install")
      system("bundle exec rails generate ym_notifications:install")

      def manifest
        copy_file "models/post.rb", "app/models/post.rb"
        copy_file "models/comment.rb", "app/models/comment.rb"
        copy_file "controllers/posts_controller.rb", "app/controllers/posts_controller.rb"
        copy_file "controllers/comments_controller.rb", "app/controllers/comments_controller.rb"

        if should_add_abilities?('Post')
          add_ability(:user, ["can [:read, :create, :file], Post", "can [:update, :destroy], Post, :user_id => user.id", "can [:create], Comment"])
          insert_into_file "app/controllers/posts_controller.rb", "\n  load_and_authorize_resource", :after => "include YmPosts::PostsController"
        end
        
        if should_add_abilities?('Comment')
          add_ability(:user, ["can [:create], Comment"])
          insert_into_file "app/controllers/comments_controller.rb", "\n  load_and_authorize_resource", :after => "include YmPosts::CommentsController"
        end
        
        # Migrations must go last
        Dir[File.dirname(__FILE__) + '/templates/migrations/*.rb'].each do |file_path|
          file_name = file_path.split("/").last
          try_migration_template "migrations/#{file_name}", "db/migrate/#{file_name.sub(/^\d+\_/, '')}"
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

      def add_ability(roles, abilities)
        [*roles].each do |role|
          tabbed_space = role==:open ? "\n    " : "\n      "
          ability_string = tabbed_space + [*abilities].join(tabbed_space)
          insert_into_file "app/models/ability.rb", ability_string, :after => "#{role} ability", :force => true
        end
      end

      def try_migration_template(source, destination)
        begin
          migration_template source, destination
        rescue Rails::Generators::Error => e
          puts e
        end
      end
      
    end
  end
end
