class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])
        @memos = current_user.memos.where(category_id: params[:id])
    end    
end
