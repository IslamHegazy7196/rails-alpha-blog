class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def new
        @article =Article.new
    end

    def create
        # debugger
        # render plain: params[:article].inspect
        @article =Article.new(article_params)
        @article.user =current_user
        if @article.save
            flash[:success] ="Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
        
    end

    def show
    end

    def edit
    end

    def update
        if @article.update(article_params)
            flash[:success] ="Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
        
    end

    def index
        @articles=Article.paginate(page: params[:page],per_page: 3)
    end

    def destroy
        if @article.destroy
            flash[:danger]="Article was successfully deleted"
            redirect_to articles_path
            else
render 'new'
        end
    end
  private
    def article_params
        params.require(:article).permit(:title, :description,category_ids:[])
    end

    def set_article
        @article=Article.find(params[:id])
    end

    def require_same_user
        if current_user != @article.user and !current_user.admin?
            flash[:danger]="You can only edit or delete your own articles"
            redirect_to root_path
        end
    end
end