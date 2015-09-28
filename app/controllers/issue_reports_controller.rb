class IssueReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_issue_report, only: [:show, :edit, :update, :destroy]

  # GET /issue_reports
  # GET /issue_reports.json
  def index
    if current_user.admin_id
      @issue_reports = IssueReport.all
    else
      @issue_reports = []
      IssueReport.all.each do |issue_report|
        if issue_report.user == current_user || issue_report.resolution_reports.exists?
          @issue_reports << issue_report
        end
      end
    end
  end

  # GET /issue_reports/1
  # GET /issue_reports/1.json
  def show
  end

  # GET /issue_reports/new
  def new
    @issue_report = IssueReport.new
  end

  # GET /issue_reports/1/edit
  def edit
  end

  # POST /issue_reports
  # POST /issue_reports.json
  def create
    @issue_report = IssueReport.new(issue_report_params)
    @issue_report.user = current_user

    respond_to do |format|
      if @issue_report.save
        format.html { redirect_to @issue_report, notice: 'Issue report was successfully created.' }
        format.json { render :show, status: :created, location: @issue_report }
      else
        format.html { render :new }
        format.json { render json: @issue_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issue_reports/1
  # PATCH/PUT /issue_reports/1.json
  def update
    respond_to do |format|
      if @issue_report.update(issue_report_params)
        format.html { redirect_to @issue_report, notice: 'Issue report was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue_report }
      else
        format.html { render :edit }
        format.json { render json: @issue_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issue_reports/1
  # DELETE /issue_reports/1.json
  def destroy
    @issue_report.destroy
    respond_to do |format|
      format.html { redirect_to issue_reports_url, notice: 'Issue report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_report
      @issue_report = IssueReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_report_params
      params[:issue_report]
    end
end
