module OrcidsHelper
  
  def retrieve_orcid(orc)
    setup_faraday_conn if @faraday_conn.blank?
    response = @faraday_conn.get do |req|
      req.url "/v3.0_rc2/#{orc}"
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{@orcid_access_token}"
    end
    JSON.parse(response.body)
  end
    
  def search_for_ringgold
    setup_faraday_conn if @faraday_conn.blank?
    response = @faraday_conn.get do |req|
      req.url "/v3.0_rc2/search/?q=ringgold-org-id:#{@orc_id}"
      req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{@orcid_access_token}"
    end
    JSON.parse(response.body)
  end
  
  def search_for_grid
    setup_faraday_conn if @faraday_conn.blank?
    response = @faraday_conn.get do |req|
      req.url "/v3.0_rc2/search/?q=grid-org-id:#{@orc_id.gsub('_', '.')}"
      req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{@orcid_access_token}"
    end
    JSON.parse(response.body)
  end
    
  # Setup the access token
  #   ideally retrieve it from an env var, but if that isn't set
  #   create a new one
  def setup_orcid_access_token
    @orcid_access_token = ENV['ORCID_ACCESS_TOKEN'] unless ENV['ORCID_ACCESS_TOKEN'].blank?
    if @orcid_access_token.blank?
      setup_faraday_conn if @faraday_conn.blank?
      response = @faraday_conn.post '/oauth/token', {
          :client_id => ENV['CLIENT_ID'],
          :client_secret => ENV['CLIENT_SECRET'],
          :scope => "/read-public",
          :grant_type => "client_credentials"
      }
      @orcid_access_token = JSON.parse(response.body)['access_token']##
    end
  end
    
  def setup_faraday_conn
    @faraday_conn = Faraday.new(:url => 'https://pub.orcid.org') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
  end
  
  # Look for the ringgold id in the first employer
  def employer?(affiliation_group)
    org = affiliation_group.first['summaries'].first
    if org['employment-summary']['organization']['disambiguated-organization'] != nil && 
      (
        org['employment-summary']['organization']['disambiguated-organization']['disambiguation-source'] == 'RINGGOLD' ||
        org['employment-summary']['organization']['disambiguated-organization']['disambiguation-source'] == 'GRID'
      )
      return true if org['employment-summary']['organization']['disambiguated-organization']['disambiguated-organization-identifier'] == @orc_id
    end
    false
  end

end
