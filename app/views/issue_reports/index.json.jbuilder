json.array!(@issue_reports) do |issue_report|
  json.extract! issue_report, :id
  json.url issue_report_url(issue_report, format: :json)
end
