@hpn = Feeling.find_by(name: 'Happiness')
@crf = Feeling.find_by(name: 'Anxiety')
@ptc = Feeling.find_by(name: 'Irritability')
@slp = Feeling.find_by(name: 'Sleep Quality')

def define_user_feeling(feeling)
  @user_feeling = current_user.user_feelings.where(feeling: feeling)
  @feeling_intensities = @user_feeling.map { |happ| happ.intensity }
  @feeling_dates = @user_feeling.map { |happ| happ.feeling_date.strftime('%D') }

  { intensities: @feeling_intensities, dates: @feeling_dates }
end

@happiness = define_user_feeling(@hpn)
@carefreeness = define_user_feeling(@crf)
@patience = define_user_feeling(@ptc)
@sleep = define_user_feeling(@slp)



json.feelings do
  json.set! :happiness do
    json.intensities @happiness[:intensities]
    json.dates @happiness[:dates]
  end

  json.set! :carefreeness do
    json.intensities @carefreeness[:intensities]
    json.dates @carefreeness[:dates]
  end

  json.set! :patience do
    json.intensities @patience[:intensities]
    json.dates @patience[:dates]
  end

  json.set! :sleep do
    json.intensities @sleep[:intensities]
    json.dates @sleep[:dates]
  end
end
