class MemosController < ApplicationController
    def index
        @memos = Memo.all
        render layout: false
    end
    
    def new
        @categories = Category.all
    end
    
    def create
        @memo = Memo.create(title:params["memos"]["title"],body:params["memos"]["body"],category_id:params["memos"]["category_id"])
        if @memo.save
            flash[:success] = 'Memo が正常に投稿されました'
            redirect_to "/"
        else
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
end
