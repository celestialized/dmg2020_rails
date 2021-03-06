class MessagesController < ApplicationController

  # GET /messages/new
  def new
    @message = Message.new
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        @message.send_message_to_rep
        format.html { redirect_to "/", notice: 'It\'s great to hear from you.  We will get back to you soon.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end



  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:first_name, :last_name, :email, :phone_number, :body)
    end
end
