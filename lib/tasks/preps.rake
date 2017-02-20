namespace :preps do
  desc 'Archive preps where all contest dates are in the past'
  task archive: :environment do
    Prep.find_each do |prep|
      prep.contests.each do |contest|
        if contest.date < Time.now
          prep.archived = true
          prep.save!
        end
      end
    end
  end
end
