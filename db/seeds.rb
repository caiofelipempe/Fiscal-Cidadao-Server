# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


country_list = [
  [ "Rua Osório Ribas de Paula", "Neste sentido, a consulta aos diversos militantes maximiza as possibilidades por conta do impacto na agilidade decisória." ],
  [ "Praça João Cabete", "Todavia, a valorização de fatores subjetivos oferece uma interessante oportunidade para verificação das formas de ação." ],
  [ "Rua Arlindo Werner", "Por conseguinte, a hegemonia do ambiente político estimula a padronização das posturas dos órgãos dirigentes com relação às suas atribuições." ],
  [ "Avenida Marabá", "É claro que o acompanhamento das preferências de consumo garante a contribuição de um grupo importante na determinação dos conhecimentos estratégicos para atingir a excelência." ]
]

country_list.each do |address, description|
  IssueReport.create(user_id: 1, latitude: -3.739333, longitude: -38.574839, address: address, description: description)
end
