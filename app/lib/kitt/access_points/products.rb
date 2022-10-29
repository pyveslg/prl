class Kitt::AccessPoints::Products < Kitt::AccessPoints
  def initialize(batch_number:)
    @url = "https://kitt.lewagon.com/api/v1/camps/#{batch_number}/pitch_session"
  end
end
