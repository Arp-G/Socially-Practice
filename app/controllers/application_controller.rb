class ApplicationController < ActionController::Base

	before_action :permitted_parameters, if: :devise_controller?


	protected


	def permitted_parameters

		devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:dob,:gender])

		devise_parameter_sanitizer.permit(:account_update, keys: [:name,:dob,:gender])

	end

end
