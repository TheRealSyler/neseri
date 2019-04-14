class SeminarsController < NeserituController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @seminars = Seminar.all
    else
      @seminars = current_user.seminars
    end
    authorize!
  end

  def show
    @seminar = Seminar.find(params[:id])
    authorize! @seminar
  end

  def edit
    @seminar = Seminar.find(params[:id])
    authorize! @seminar
  end

  def update
    @seminar = Seminar.find(params[:id])

    authorize! @seminar

    if @seminar.update(seminar_params)
      redirect_to @seminar, notice: I18n.t('seminar.saved')
    else
      render :edit
    end
  end

  def new
    @seminar = Seminar.new
    authorize!
  end

  def create
    @seminar = Seminar.new(seminar_params)
    @seminar.creator = current_user
    authorize!

    if @seminar.save
      redirect_to @seminar, notice: I18n.t('seminar.saved')
    else
      render :new
    end
  end

  private

  def seminar_params
    params.require(:seminar).permit(:title, :subtitle, :description,
      :start_date, :end_date,
      :cancellation_time, :cancellation_reason,
      :attendees_minimum, :attendees_maximum, :attendees_preconditions, :please_bring, 
      :room_extras, :room_material,
      :seminar_kind_id,
      :royalty_participant, :royalty_participant_reduced, :material_cost, :honorar,
      seminar_instructors_attributes: [:id, :email, :comment, :accommodation, :qualification, :_destroy]
    )
  end
end
