class ConversationsController < ApplicationController
  layout false
  #before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :mark_all_as_read]

  def index
    sleep(1)
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 7)
  end

  def show
    set_content_title(nil, ['Conversation'])
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    unread_notifications_count
  end

  def mark_all_as_read
    @mailbox.conversations(unread: true).each do |conversation|
      conversation.mark_as_read(current_user)
    end
    index
    redirect_to :back
  end

  def destroy
    @conversation.move_to_trash(current_user)
    unread_notifications_count
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def not_check_authorization?
    true
  end
end
