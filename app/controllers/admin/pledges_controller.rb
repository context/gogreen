class Admin::PledgesController < AdminController
  make_resourceful do
    actions :index
    response_for :index do |format|
      format.html {}
      format.csv do 
        csv_string = FasterCSV.generate do |csv|
          csv << Pledge::CSV_HEADERS
          @pledges.each { |pledge| csv << pledge.to_csv }
        end
        csv_filename = "#{Time.now.strftime("%Y-%m-%d")}_export_pledges.csv"
        csv_filename = "#{Time.now.strftime("%Y-%m-%d")}_export_pledges_#{@contest.name.gsub(/,? /, '_')}.csv" if @contest
        if request.env['HTTP_USER_AGENT'] =~ /msie/i
          send_data csv_string, :type => 'text/plain', :filename => csv_filename, :disposition => 'attachment'
        else
          send_data csv_string, :type => 'text/csv', :filename => csv_filename, :disposition => 'attachment'
        end
      end
    end
  end
end
