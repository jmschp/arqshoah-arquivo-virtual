# rubocop:disable Rails/Output

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

def date_generator(type = nil)
  date = Faker::Date.between(from: 80.years.ago, to: Date.current)
  type ||= %i[full_date year_month year no_date].sample
  case type
  when :full_date
    { year: date.year, month: date.month, day: date.day }
  when :year_month
    { year: date.year, month: date.month, day: nil }
  when :year
    { year: date.year, month: nil, day: nil }
  when :no_date
    { year: nil, month: nil, day: nil }
  end
end

#=======================================# Admin User #=======================================#
puts "Creating admin users"

AdminUser.create!(
  email: "jmiguelpimenta@icloud.com",
  email_confirmation: "jmiguelpimenta@icloud.com",
  name: "Miguel Pimenta",
  password: "123123",
  password_confirmation: "123123",
  invitation_limit: 10
)

#=======================================# Commoner #=======================================#
puts "Creating commoners"

15.times do
  Commoner.create!(first_name: Faker::Name.unique.first_name, last_name: "#{Faker::Name.unique.last_name} Commoner")
end

#=======================================# Language #=======================================#
puts "Creating languages"

5.times { Language.create!(name: Faker::Nation.unique.language) }

#=======================================# Organization #=======================================#
puts "Creating organizations"

5.times { Organization.create!(name: Faker::Company.unique.name) }
5.times { Organization.create!(name: Faker::Book.unique.publisher) }

#=======================================# Religion #=======================================#
puts "Creating religions"

religions = [
  "Cristianismo", "Islamismo", "Ateu", "Hinduísmo",	"Budismo",
  "Siquismo", "Espiritismo", "Judaísmo", "Bahá'í", "Jainismo", "Xintoísmo",
  "Cao Dai", "Zoroastrismo", "Tenrikyo", "Neopaganismo", "Rastafári"
]

religions.each { |religion| Religion.create!(name: religion) }

#=======================================# Survivor #=======================================#
puts "Creating survivors"

5.times do
  birth_date = date_generator
  death_date = date_generator

  survivor = Survivor.new(
    first_name: Faker::Name.first_name,
    last_name: "#{Faker::Name.last_name} Survivor",
    name_variation: Faker::Name.name_with_middle,
    birth_date_day: birth_date[:day],
    birth_date_month: birth_date[:month],
    birth_date_year: birth_date[:year],
    birth_place: Faker::Address.full_address,
    death_date_day: death_date[:day],
    death_date_month: death_date[:month],
    death_date_year: death_date[:year],
    death_place: Faker::Address.full_address,
    gender: %i[male female].sample,
    family_members: Faker::Lorem.paragraphs(number: 10).join(" "),
    academic_formation: Faker::Appliance.equipment,
    professional_activities: Faker::Lorem.paragraphs(number: 10).join(" "),
    description: Faker::Lorem.paragraphs(number: 10).join(" "),
    observation: Faker::Lorem.paragraphs(number: 10).join(" "),
    religion: Religion.all.sample
  )
  rand(1..3).times do
    survivor.interviews_given.build(
      interviewer: Commoner.all.sample,
      location: Faker::Address.full_address,
      date: Faker::Date.between(from: 10.years.ago, to: Date.current)
    )
  end
  survivor.save!
end

#=======================================# Savior #=======================================#
puts "Creating saviors"

5.times do
  birth_date = date_generator
  death_date = date_generator

  savior = Savior.new(
    first_name: Faker::Name.first_name,
    last_name: "#{Faker::Name.last_name} Savior",
    name_variation: Faker::Name.name_with_middle,
    birth_date_day: birth_date[:day],
    birth_date_month: birth_date[:month],
    birth_date_year: birth_date[:year],
    birth_place: Faker::Address.full_address,
    death_date_day: death_date[:day],
    death_date_month: death_date[:month],
    death_date_year: death_date[:year],
    death_place: Faker::Address.full_address,
    gender: %i[male female].sample,
    family_members: Faker::Lorem.paragraphs(number: 10).join(" "),
    academic_formation: Faker::Appliance.equipment,
    professional_activities: Faker::Lorem.paragraphs(number: 10).join(" "),
    description: Faker::Lorem.paragraphs(number: 10).join(" "),
    observation: Faker::Lorem.paragraphs(number: 10).join(" "),
    religion: Religion.all.sample
  )
  savior.save!
end

#=======================================# Archive #=======================================#
puts "Creating archives"

archive_classification = %w[Confidencial Ostensivo Outro Reservado Secreto Urgente]
archive_classification.each { |name| ArchiveClassification.create(name: name) }

archive_type = [
  "Agenda", "Anais", "Artigos", "Ata", "Atestado de antecedentes", "Atestado medico",
  "Auto de busca e apreensão", "Auto de infração", "Auto de Inquérito Policial", "Auto de qualificação",
  "Autorização", "Autuação", "Aviso", "Bilhete", "Boletim", "Boletim de ocorrência", "Carta",
  "Cartão de Registro de Passageiro", "Cartão postal", "Cartaz", "Cartilha", "Certidão de casamento",
  "Certidão de nascimento", "Circular", "Comunicado", "Concessão", "Declaração", "Decreto-Lei",
  "Despacho", "Diário", "Discurso", "Dissertação", "Edital", "Entrevista", "Escritura", "Estatuto",
  "Ficha Consular de Qualificação", "Ficha de Identificação", "Folha de Antecedentes Criminais",
  "Folha de Identificação para Pedido de Visto", "Folha de Identificação para Registro de Entrada",
  "Formulário", "Formulário de censura postal", "Formulário de Salvo-conduto", "Fotografia",
  "Guia de Identificação", "Guia de prisão", "Guia de soltura", "Informe", "Jornal", "Lei", "Licença de Retorno",
  "Lista", "Lista de passageiros", "Livro", "Manifesto", "Manual", "Mapa", "Memorando", "Memorial",
  "Minuta", "Nota", "Oficio", "Orçamento", "Ordem de prisão", "Ordem de serviço", "Ordem de soltura",
  "Outro", "Panfleto", "Parecer", "Passaporte", "Planta", "Poema", "Portaria", "Poster", "Projeto",
  "Projeto de Decreto-Lei", "Projeto de Lei", "Protocolo", "Radiotelegrama", "Recibo", "Regimento",
  "Registro de Deportação de Judeus", "Registro de Judeus", "Relação de nomes", "Relatório", "Reportagem",
  "Requerimento", "Resenha", "Resolução", "Revista", "Telegrama", "Termo de declaração", "Tese", "Tradução"
]
archive_type.each { |name| ArchiveType.create!(name: name) }

5.times do
  date = date_generator
  Archive.create!(
    issuing_agency: Organization.all.sample,
    receiver_agency: Organization.all.sample,
    archive_type: ArchiveType.all.sample,
    archive_classification: ArchiveClassification.all.sample,
    date_day: date[:day],
    date_month: date[:month],
    date_year: date[:year],
    document_code: Faker::Code.npi,
    document_number: Faker::Code.rut,
    title: Faker::Lorem.unique.sentence(word_count: rand(3..10), supplemental: true),
    location: Faker::Address.city,
    description: Faker::Lorem.paragraphs(number: 10).join(" "),
    observation: Faker::Lorem.paragraphs(number: 10).join(" "),
    donor: [Organization.all.sample, Person.all.sample].sample,
    language: Language.all.sample,
    to_name: Faker::Name.name_with_middle,
    to_role: Faker::Military.army_rank,
    from_name: Faker::Name.name_with_middle,
    from_role: Faker::Military.army_rank,
    page_count: rand(0...10),
    people_cited: Person.all.sample(rand(1..10))
  )
end

#=======================================# Iconography #=======================================#
puts "Creating iconographies"

iconography_technics = [
  "a oleo", "agua forte", "agua forte e ponta-seca", "aguada", "aquarela", "aquarela e guache", "digital", "gelatina",
  "gelatina/prata", "grafite", "guache", "impresso", "lapis de cor sob papel cartão", "litografia",
  "litografia em chapa metálica", "oleo com areia", "ponta-seca", "relevo", "tempera", "tempera e oleo", "tinta bistre",
  "tinta bistre a pincel", "tinta bistre aguada", "tinta preta", "tinta preta a pena",
  "tinta preta a pena aguada e aquarela", "tinta preta a pena e aguada", "tinta preta a pena e aquarela",
  "tinta preta a pena e tinta terra de siena aguada", "tinta preta a pena, aquarela e tinta terra de siena a pincel",
  "tinta preta a pena, tinta bistre aguada e aquarela", "tinta preta a pena, tinta sepia aguada e guache branco",
  "tinta preta aguada", "tinta preta e amarela aguadas", "tinta preta e aquarela",
  "tinta preta e vermelha a pena e aquarela", "tinta sepia", "tinta sepia a pena e aguada", "tinta sepia aguada",
  "tinta terra de siena a pena", "tinta terra de siena a pena e tinta bistre a pincel e aguada",
  "tinta terra de siena aguada", "tinta vermelha a pena", "tinta vermelha a pena e tinta preta e amarela aguadas",
  "xilogravura"
]
iconography_technics.each { |name| IconographyTechnic.create!(name: name) }

iconography_types = [
  "Adesivo", "Aquarela", "Caricatura", "Charge", "Desenho", "Escultura", "Estudo", "Fotografia",
  "Gravura", "Litografia", "Mapa [rota de fuga]", "Pintura", "Provisório", "Xilografia"
]
iconography_types.each { |name| IconographyType.create!(name: name) }

iconography_supports = %w[Alvenaria Bronze Granito Madeira Metal Papel Tecido Tela]
iconography_supports.each { |name| IconographySupport.create!(name: name) }

images_path = Dir.glob(Rails.root.join("db/images_seed/{*.jpg,*.png}"))
puts "Creating iconographies without image, setting validate to false" unless images_path.length.positive?

(images_path.length.positive? ? images_path.length : 10).times do |i|
  date = date_generator

  ico = Iconography.new(
    title: Faker::GreekPhilosophers.unique.quote,
    subtitle: Faker::Lorem.sentence(word_count: rand(3..15), supplemental: true),
    date_day: date[:day],
    date_month: date[:month],
    date_year: date[:year],
    original: [false, true].sample,
    location: Faker::Address.full_address,
    description: Faker::Lorem.paragraphs(number: 10).join(" "),
    observation: Faker::Lorem.paragraphs(number: 10).join(" "),
    donor: [Organization.all.sample, Person.all.sample].sample,
    iconography_technic: IconographyTechnic.all.sample,
    iconography_type: IconographyType.all.sample,
    iconography_support: IconographySupport.all.sample,
    people_cited: Person.all.sample(rand(1..10))
  )

  if images_path.present?
    ico.image.attach(
      io: File.open(images_path[i]),
      filename: File.basename(images_path[i]),
      content_type: Rack::Mime.mime_type(File.extname(images_path[0]))
    )
    ico.save!
  else
    ico.save!(validate: false)
  end
end

#=======================================# Press #=======================================#
puts "Creating presses"

newspaper_type = %w[Artigo Cronica Entrevista Noticia Resenha Informe Carta]
newspaper_type.each { |type| NewspaperType.create!(name: type) }

5.times do
  date = date_generator

  Newspaper.create!(
    title: Faker::Lorem.unique.words(number: rand(4..8)).join(" "),
    location: Faker::Address.full_address,
    date_day: date[:day],
    date_month: date[:month],
    date_year: date[:year],
    print_number: Faker::Lorem.sentence(word_count: rand(1...3), supplemental: true),
    agency: Organization.all.sample,
    newspaper_type: NewspaperType.all.sample,
    language: Language.all.sample,
    author: Commoner.all.sample,
    description: Faker::Lorem.paragraphs(number: 10).join(" "),
    observation: Faker::Lorem.paragraphs(number: 10).join(" "),
    people_cited: Person.all.sample(rand(1..10))
  )
end
# rubocop:enable Rails/Output
