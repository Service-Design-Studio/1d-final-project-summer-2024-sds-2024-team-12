module BackButtonHelper
  def back_button_path
    request.referer == request.original_url ? root_path : request.referer
  end
end
