# @hpn = Feeling.find_by(name: 'Happiness')
# @crf = Feeling.find_by(name: 'Anxiety')
# @ptc = Feeling.find_by(name: 'Irritability')
# @slp = Feeling.find_by(name: 'Sleep Quality')

# def define_user_feeling(feeling)
#   @user_feelings = current_user.user_feelings.where(feeling: feeling)
#   @feeling_intensities = @user_feelings.map { |happ| happ.intensity }
#   @feeling_dates = @user_feelings.map { |happ| happ.feeling_date.strftime('%D') }

#   { intensities: @feeling_intensities.reverse, dates: @feeling_dates.reverse }
# end

@happiness = []
@carefreeness = []
@patience = []
@sleep = []
@dates = []

current_user.user_feelings.each do |feeling|
  @happiness.push(feeling.happiness)
  @carefreeness.push(feeling.carefreeness)
  @patience.push(feeling.patience)
  @sleep.push(feeling.sleep_quality)
  @dates.push(feeling.feeling_date)
end

json.feelings do
  json.set! :happiness do
    json.intensities @happiness
    json.dates @dates
  end

  json.set! :carefreeness do
    json.intensities @carefreeness
    json.dates @dates
  end

  json.set! :patience do
    json.intensities @patience
    json.dates @dates
  end

  json.set! :sleep do
    json.intensities @sleep
    json.dates @dates
  end
end
