class ArticlesController < ApplicationController
    def new
        @article =Article.new
    end

    def create
        # debugger
        # render plain: params[:article].inspect
        @article =Article.new(article_params)
        # @article.user =User.first
        if @article.save
            flash[:success] ="Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
        
    end

    def show
        @article=Article.find(params[:id])
    end

    def edit
        @article=Article.find(params[:id])
    end

    def update
        @article=Article.find(params[:id])
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
        @article=Article.find(params[:id])
        if @article.destroy
            flash[:danger]="Article was successfully deleted"
            redirect_to articles_path
            else
render 'new'
        end
    end
  private
    def article_params
        params.require(:article).permit(:title, :description)
    end
end