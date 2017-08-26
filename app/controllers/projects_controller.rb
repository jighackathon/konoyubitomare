class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    # params = params.permit(:skills = [])
    # skills = params[:skills]
    # skills = skills.delete_if { |s| s.blank? }
    #
    # @projects = Project.where( # TODO

    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params.require(:id))
    @messages = @project.chat_messages
    @new_messages = @project.chat_messages.build(user_id: current_user.id, project_id: params.require(:id))
    @members = @project.project_members.select { |m| m.status == 'member' }
    @temp_members = @project.project_members.select { |m| m.status == 'temp_member' }
    @user_is_owner = (current_user.id == @project.user_id)
  end

  def apply
    ProjectMember.create(user_id: current_user.id, project_id: params[:id], status: 'temp_member')

    redirect_to Project.find(params[:id]), flash: { success: 'プロジェクトへの参加を申請しました' }
    # redirect_to @project, notice: 'Project was successfully created.'
  end

  def approve
    binding.pry
    params.require(:user_id, :project_id)
    application = ProjectMember.where(project_id: params[:project_id]).where(user_id: params[:user_id]).take
    application.update(status: 'member')

    redirect_to :show, flash: { success: '参加申請を承認しました。' }
  end

  def message
    params = params.require(:user_id, :content, :project_id)
    ChatMessage.create(params).hoge

    redirect_to :show, flash: { success: 'メッセージを追加しました。' }
  end

  # GET /projects/new
  def new
    @project = Project.new
    @skills = Skill.all
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    # @params = project_params
    # @project = Project.new(title: @params[:title], detail: @params[:detail])
    # @params[:project_skill_ids].each do |id|
    #   @project.project_skills.build(skill_id: id)
    @project = Project.new(project_params)
    # binding.pry
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :detail, {:skill_ids => []})
    end
end
