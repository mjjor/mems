json.array!(@profiles) do |profile|
  json.extract! profile, :item, :id
end