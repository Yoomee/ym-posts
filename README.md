NOTES:

1. May need to include jquery.ui.autocomplete styles in app, e.g. in application.css:
```
 *= require jquery.ui.autocomplete
```

2. Init the comments form in document ready, e.g. in application.js.coffee:
```
  YmComments.Form.init({submitOnEnter: true})
```

3. Don't forget to also call the ym_tags install if neccessary, e.g. in terminal:
```
   $ rails g ym_tags:install
```

4. For each place you are rendering posts, you will need to set up @posts in the correspoding controller, and have a js partial.  For example if you have posts on a users#show page  

  **app/controllers/users_controller.rb**
```
  class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.paginate(page: params[:page])
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
  end
```
  **app/views/users/show.js.erb**  
```
$('.posts').html('<%=escape_javascript(render('posts/posts', :posts => @posts))%>').removeClass('loading');
```
