class MeetingController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def index
    render json: current_user.meetings
  end

  def show
    render json: Meeting.find(params[:id])
  end

  def create
    meeting = Meeting.new(name: generate_name)
    employees = User.where(role: 1)
    meeting.users << current_user
    meeting.users << employees.first if employees
    if (meeting.save)
      render json: meeting
    else
      render json: meeting.errors
    end
  end

  private
  def generate_name
    (0...14).map { (65 + rand(26)).chr }.join
  end
end
