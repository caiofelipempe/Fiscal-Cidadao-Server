class ResolutionReportController < ApplicationController
  before_action :authenticate_user!
  before_action :set_issue_report, only: [:create, :destroy]
  before_action :set_resolution_report, only: :destroy

  def new
    @resolution_report = ResolutionReport.new
  end

  def create
    authenticate_admin

    @resolution_report = ResolutionReport.new(issue_params)
    @resolution_report.issue_report = @issue_report
    @resolution_report.user = current_user

    respond_to do |format|
      if @resolution_report.save
        format.html { redirect_to @issue_report, notice: 'Resposta registrada' }
        format.json { render :show, status: :created, location: @issue_report }
      else
        format.html { redirect_to @issue_report }
        format.json { render json: @resolution_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user == @issue_report.user || current_user.admin != nil
      @resolution_report.destroy
      respond_to do |format|
        format.html { redirect_to issue_report_path(@issue_report), notice: 'Issue report was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      raise StandardError.new 'Access denied.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resolution_report
      @resolution_report = ResolutionReport.find(params[:id])
    end

    def set_issue_report
      @issue_report = IssueReport.find(params[:issue_report_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:resolution_report).permit(:description)
    end

end
