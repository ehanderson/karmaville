class UsersController < ApplicationController
  def index
    @page_number = params["page"].to_i

    if @page_number == 0
      @users = User.by_karma.limit(10)
    else
      @users = User.page(@page_number)
    end
  end

end
