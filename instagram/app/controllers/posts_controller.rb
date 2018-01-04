class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #befor_action은 하나의 액션을 실행하기 전에 해당 메소드를 실행
  #only:안에 있는 거에서만 set_post를 실행하겠다.
  before_action :authenticate_user!, except: :index
  # before_action :is_owner?, only: [:edit, :update, :destroy]
  load_and_authorize_resource param_method: :post_params
  #skip_authorize_resource only: [:new, :index] 이것도 생략 해주는 애??
  #load_and_authorize_resource excpt: :edit, param_method: :post_params 이렇게하면 edit은 넘어감

  #이렇게 하면 각각에 authorize 해줄 필요 없음

  def index
    if params["post"].nil?
      @posts=Post.all.reverse
    else
      @posts=Post.where("title LIKE ?", "%#{params["post"]["q"]}%")
      #%붙여주면
    end
  end

  def new
  end

  def create
    # Post.create(post_params)
     current_user.posts.create(post_params)
     # current_user => User의 인스턴스
     # current_user.posts => Post의 인스턴스
    redirect_to '/'
    puts '*****************************'
    puts post_params
    puts '*****************************'
  end

  def show
    # @post=Post.find(params[:id])

    authorize! :read,@post
  end

  def edit
    authorize! :update, @post
    #@post(글)에 대한 update 권한이 있는지 확인
    # @post=Post.find(params[:id])
  end

  def update
    # post=Post.find(params[:id])
  # @post.update(title: params[:title], content: params[:content])
  authorize! :update, @post
  @post.update(post_params)
    redirect_to '/'
  end

  def destroy
    authorize! :destroy, @post
    # post=Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end

  private
#private 위에는 public이라서 url로 요청오면 그것을 받아서 view를 보여준다.
#private은 해당 컨트롤러(PostsController)에서만 사용 가능함.
#객체에서 private 속성을 가지면 클래스 내부에서만 접근이 가능했었고, 이외의 상속 받은 클래스나 객체 인스턴스에서도 접근이 불가능했음.

  def set_post
    @post=Post.find(params[:id])
  end

  #strong parameter
  #특정 파라미터의 특정 값만 쓸거야라고 해주는거
  #실제로 쓸 파라미터들만 가져오는? 화이트리스트?
  def post_params
    params.require(:post).permit(:title,:content,:postimage,:q)
  end

  def is_owner?#?없어도 됨
    #게시글의 주인, 로그인한 사람이 같지 않으면
    redirect_to '/' and return unless @post.user_id==current_user.id
    #unless가 같지 않으면 참이니깐 같지 않으면 redirect_to '/'
    #unless => if @post.user_id != current_user.id
    #redirect_to '/'

  end

end
