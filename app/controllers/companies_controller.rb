class CompaniesController < ApplicationController
  # hacktastic!!!
  @@companies = [Company.new(:_id => '1', :name => "Chevron", :description => "Drunk from petro-dollar$", :email => "someone@chevron.com"),
                 Company.new(:_id => '2', :name => "Microsoft", :description => "500-pound gorilla", :email => "someone@microsoft.com")]
  def index
    @companies = @@companies
  end
  def show
    @company = @@companies.find{|c| c._id == params[:id]}
  end
end
