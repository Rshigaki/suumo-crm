company = Company.first
["SUUMO", "Homepage", "Instagram", "Referral", "Walk-in"].each do |name|
  MediaSource.find_or_create_by!(name: name, company: company)
end
