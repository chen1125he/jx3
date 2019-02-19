SERVICE_DATA = JSON.parse(File.read(Rails.root.join('db/fixtures/data/services.json')))

ActiveRecord::Base.transaction do
  SERVICE_DATA.each do |data|
    area = Area.seed(:name) do |a|
            a.name = data['area_name']
          end
    data['services'].each do |service|
      Service.seed(:name, :area_id) do |s|
        s.area_id = area[0].id
        s.name = service['name']
      end
    end
  end
end
