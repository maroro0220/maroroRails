### devise로 회원가입 기능 구현하기

---

*[devise](https://github.com/plataformatec/devise)

1. 기초 시작하기

- `Gemfile`에 devise 추가 후 `bundle install` 하기

     ```gem 'devise' ```	

```console
$rails generate devise:install
```

	>주요하게 만들어지는 것들..
	>
	>devise.rb

- User 모델 만들기 with devise

  ```console
  $rails g devise User
  ```

  > 주요하게 만들어지는 것들 ..
  >
  > migration파일/user.rb / routes에 경로 추가 됨.

- migration

  > 별도의 커스터마이징 column이 없다면 바로, 아니면 추가하고 실행할 것.

  ```console
  $rake db:migrate
  ```

- 서버 실행

  - `rake routes` 로 만들어진 url들 확인.

  - 예시 

    - /users/sign_up : 회원가입

    - /users/sign_in : 로그인

    - /users/sign_out : 로그아웃

      주의:get이 아니라 delete http method임. 그래서 url 접근 불가

2. 추가내용

- 사용 가능한 helper

  - current_user: 로그인 되어 있으면, 해당 user를 불러올 수 있다.
  - user_sign_in? : 로그인 되어있는지 => return boolean

- 로그인해야 페이지 보여주는 법(posts_controller.rb)

  ```ruby
  before_action :authenticate_user!, except: :index
  ```

- view에서 로그인/로그아웃/회원가입 링크 보여주기

  (application.html.erb)

  ```erb
  <%if user_signed_in?%>
    <li>
      <%=current_user.email%>님이 login
      <%=link_to('logout',destroy_user_session_path,method: :delete)%>
    </li>
    <%else%>
    <h4>
      <li>
        <%= link_to('login',new_user_session_path)%>
        /
        <%= link_to('sign in',new_user_registration_path)%>
      </li>
    </h4>
  <%end%>
  ```

- Customizing 할 수 있는 devise view파일 보기

  ```console
  $ rails g devise:views
  ```

- devise controller 커스터마이징 하기

  ```console
  $ rails g devise:controllers users
  ```

  `users/` 많은 컨트롤러가 생김...

  반드시 routes.rb 수정

  ```ruby
  devise_for :users, controllers:{
    sessions: 'users/sessions'
    }
  ```

  controller만들면 주석 해제만 하면되는데 

  ```ruby
  class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_signup_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]
    
  protected
  def cfonfigure_sign_up_params
    devise_parameter_sanitize.permit(:sign_up, key: [:username])
  end
  def configure_accout_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
  end
  ```

  ​

  안만들고 그냥 아래 customizing column 처럼 해도 됨

  ​

- Customizing column

  1)`migrate` 파일에 원하는 대로 만들기!

  2) 해당 view에서 input 박스 만들기!

  3) strong parameter 설정 (컨트롤 러 직접 가)

```ruby
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
end
```



---

---





# note

URI는 자원의 정보. 명사를사용함. (posts, users)

자원에 대한 행위는 HTTP Method. get ‘/posts’ 게시글을가져온다 post ‘/posts’ 게시글을 등록한다 

 

helper를 사용해서restful을 쓸 수 있음?

 

 

 

 

Devise – 회원가입 구현할 때 

<https://github.com/plataformatec/devise>

gem 'devise'

$ bundle install

```
$rails generate devise:install
```

 

bash창에서

<pclass="notice"><%= notice %></p>

<pclass="alert"><%= alert %></p>

복사

application.html.erb

밑에 form밑에 붙여넣기

$ rails g devise User

$rake db:migrate

<%if user_signed_in?%>

 <li>

   <%=current_user.email%>님이 login

 </li>

<%else%>

 

 

 

```
$rails generate devise:views
```

 

views-devise-registrations-new.html.erb 한번보기

email에autofocus:true인데 자동으로 autofocus됨

validation도 걸려있음 이미 있는 email이나 pw숫자가 작으면 뭐 뜸

 

 

 

 

 

username추가할 때?

```
 
```

```
class ApplicationController < ActionController::Base
```

```
  before_action :configure_permitted_parameters, if: :devise_controller?
```

```
 
```

```
  protected
```

```
 
```

```
  def configure_permitted_parameters
```

```
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
```

```
  end
```

```
end
```

 

applicationcontroller에 추가하는 이유는 devise는 controller가 없어서? 까서 넣어도 되는데 그렇게하면 devisecontroller를 만드는순간 설정할게 더 생김

저거 추가하는 이유는 strong parameter을 쓰려고?

 

 

 

<https://github.com/plataformatec/devise/wiki>

wiki에 admin검색

 

 

???????????????????????????????????

rails db:migrate

 

 

 

 

$rails c

pry> User.create(username: “admin, email:“adm@adm”, adadmin;:true)

 

$rails g controller users

 

class UsersController 

before_action :authenticate_user!

befor_action :is_admin?

def index

​           @users=User.all

end

private 

def is_admin?

redirect_to ‘/’and return unless current_user.admin?

end

end

 

 

 

 

<% @users.each do |user|%>

<%=user.id%>

<%=user.email%>

<%=user.username%>

<hr />

<%end%>

 

 

 

get ‘/users/index’ =>’users#index

 

admin권한을 주려면

pry> User.all

User.find(1).update_attribute(:admin,true)

 

새로 만드려면

User.create(username: ‘admin1’, email:’admin@admin’, password: ‘123123’, admin: true)

 

 

 

 

<%= @post.user.username %>

이렇게 바로 글쓴 사람의 username을 가져올 수 있음

post에 저장된user_id를 가지고 user를 불러오고 그 속에서username을 가져옴

 

 

유저가 쓴 페이지는

User.first.posts

하면 user가 가진 게시글들이 다 나옴

 게시글 여러 개니깐 posts

