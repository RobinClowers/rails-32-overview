# Create posts

*at the terminal*

``` bash
rails generate scaffold Post title:string content:text
```

# Customize home page

*at the terminal*
``` bash
rails generate controller home index
```

*config/routes.rb*

```ruby
root :to => 'home#index'
```

*app/views/home/index.html.erb*

```erb
<p>Check out my <%= link_to :posts, posts_path %>!</p>
```

# Add form confirmation

*app/assets/javascripts/posts.js.coffee*

```coffeescript
$ ->
  $('form').submit (e) ->
    unless confirm 'are you sure?'
      e.preventDefault()
```

# Add Comments

*at the terminal*
``` bash
rails generate model Comment commenter:string body:text post:references
```

*app/models/post.rb*

```ruby
has_many :comments
```

*app/routes.rb*

```ruby
resources :posts do
  resources :comments
end
```

*app/controllers/comments_controller.rb*

```ruby
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to post_path(@post)
  end
end
```

*app/views/comments/_form.html.erb*

```erb
<%= form_for([@post, @post.comments.build]) do |f| %>
  <div class="field">
    <%= f.label :commenter %><br />
    <%= f.text_field :commenter %>
  </div>
  <div class="field">
    <%= f.label :body %><br />
    <%= f.text_area :body %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

*app/views/coments/_comment.html.erb*

```erb
<p>
  <b>Commenter:</b>
  <%= comment.commenter %>
</p>
<p>
  <b>Comment:</b>
  <%= comment.body %>
</p>
```

# Deleting Comments

*app/views/comments/_comment.html.erb*

```erb
<p>
  <%= link_to 'Delete Comment', [comment.post, comment],
               :confirm => 'Are you sure?',
               :method => :delete %>
</p>
```

*app/controllers/comments_controller.rb*

```ruby
def destroy
  @comment = Comment.find params[:id]
  @comment.destroy
  redirect_to post_path(@comment.post)
end
```
