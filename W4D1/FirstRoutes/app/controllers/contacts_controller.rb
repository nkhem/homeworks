class ContactsController < ApplicationController
  def index
    if params[:user_id]
      @contacts = Contact.where(user_id: params[:user_id])
    else
      @contacts = Contact.all
    end

    render json: @contacts
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
