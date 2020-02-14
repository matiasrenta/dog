class CommentsController < ApplicationController

  def create
    @commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(@commentable, current_user.id, body)

    respond_to do |format|
      if @comment.save
        make_child_comment
        notify_mention_users
        format.html  { redirect_to(:back, :notice => t('activerecord.messages.comment_successfully_added')) }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return '' if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end

  def notify_mention_users
    recipients = Notificator.recipients_from_body(body)
    if recipients.size > 0
      entity_link = view_context.link_to(@commentable.try(:name), eval("#{@commentable.class.name.underscore}_path(@commentable)"), class: 'display-normal')
      Notificator.send(current_user, recipients, "<strong>#{current_user.name}</strong> te etiquetó en un comentario de <strong>#{t("activerecord.models.#{@commentable.class.name.underscore}.one")}</strong> #{entity_link}")
    end
  end
end
