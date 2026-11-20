class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build
  end

def create
  @list = List.find(params[:list_id])
  @bookmark = @list.bookmarks.build(bookmark_params)

  if @bookmark.save
    redirect_to list_path(@list), status: :see_other
  else
    render :new, status: :unprocessable_entity
  end
end

def destroy
  @bookmark = Bookmark.find(params[:id])
  @list = @bookmark.list
  @bookmark.destroy!
  redirect_to list_path(@list), status: :see_other
end


private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
  
end
