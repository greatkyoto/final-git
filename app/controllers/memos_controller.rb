class MemosController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy]
    def index
        if logged_in?
            @memo = current_user.memos.build
            @memos = current_user.memos.order('created_at DESC').page(params[:page])
            render layout: false
        end    
    end
    
    def new
        @categories = Category.all
    end
    
    def create
        @memo = current_user.memos.create(title:params["memos"]["title"],body:params["memos"]["body"],category_id:params["memos"]["category_id"])
        if @memo.save
            flash[:success] = 'Memo が正常に投稿されました'
            redirect_to "/"
        else
            @memos = current_user.memos.order('created_at DESC').page(params[:page])
            flash.now[:danger] = 'Memo が投稿されませんでした'
            render :new
        end
    end
    
    def destroy
        memo = Memo.find(params["id"])
        memo.destroy
        flash[:success] = 'Message は正常に削除されました'
        redirect_to "/"
    end    
    
    def edit
        @memo = Memo.find(params["id"])
    end
    
    def update
        memo = Memo.find(params["id"])
        memo.title = params["memos"]["title"]
        memo.body = params["memos"]["body"]
        memo.category_id = params["memos"]["category_id"]
        memo.save
        if memo.save
          flash[:success] = 'メモ は正常に更新されました'
          redirect_to "/"
        else
          flash.now[:danger] = 'メモ は更新されませんでした'
          render :edit
        end
        
    end    
    
    private
    def memo_params
       params.require(:memos).permit(:title,:body,:category_id) 
    end  
    
    def correct_user
        @memo = current_user.memos.find_by(id: params[:id])
        unless @memo
            redirect_to root_url
        end
    end    
end
