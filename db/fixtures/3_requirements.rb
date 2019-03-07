REQUIREMENT_DATA = JSON.parse(File.read(Rails.root.join('db/fixtures/data/pengren_requirements.json')))
REQUIREMENT_DATA += JSON.parse(File.read(Rails.root.join('db/fixtures/data/fengren_requirements.json')))
REQUIREMENT_DATA += JSON.parse(File.read(Rails.root.join('db/fixtures/data/yishu_requirements.json')))
REQUIREMENT_DATA += JSON.parse(File.read(Rails.root.join('db/fixtures/data/zhuzao_requirements.json')))

ActiveRecord::Base.transaction do
  REQUIREMENT_DATA.each do |data|
    owner = Product.find_by(name: data['owner_name'])

    data['requirements'].each do |requirement|
      material = Product.find_by(name: requirement['material_name'])

      Requirement.seed(:owner_id, :material_id) do |p|
        p.owner_id = owner.id
        p.material_id = material.id
        p.amount = requirement['amount']
      end
    end
  end
end
