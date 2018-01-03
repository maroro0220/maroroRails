class PostsController < ApplicationController
  before_action :set_post, only: [:read, :edit, :update, :destroy]
  #befor_action은 하나의 액션을 실행하기 전에 해당 메소드를 실행
  #only:안에 있는 거에서만 set_post를 실행하겠다.

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
    Post.create(post_params)
    redirect_to '/'
    puts '*****************************'
    puts post_params
    puts '*****************************'
  end

  def read
    # @post=Post.find(params[:id])
  end

  def edit
    # @post=Post.find(params[:id])
  end

  def update
    # post=Post.find(params[:id])
  # @post.update(title: params[:title], content: params[:content])
  @post.update(post_params)
    redirect_to '/'
  end

  def destroy
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

end
