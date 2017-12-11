# frozen_string_literal: true

require 'faker'
require 'json'
require 'base64'

class MedicalCenter1
  def self.token
    'eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl9pZCI6MX0.YBoHU254D5ts-jG3Pxd7s0i8B8Qb-Ju7OSR7k6IN4pE'
  end

  def self.patient
    data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:edad] = rand(0..110)
    data
  end

  def self.professional
    data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:apellido] = Faker::Name.last_name
    data[:edad] = rand(0..110)
    data[:nacionalidad] = Faker::Demographic.demonym
    data[:job_title] = Faker::Job.title
    data[:grant_date] = Faker::Date.backward
    data[:granting_entity] = Faker::University.name

    data[:numero_registro] = Faker::Number.number(9)
    data[:fecha_registro] = Faker::Date.backward
    data[:especialidad] = 1 # <-- como es una referencia de la tabla especialidad... no se que colocar
    data[:freelance] = Faker::Boolean.boolean
    data[:telefono] = Faker::Number.number(9)
    data[:email] = Faker::Internet.email(data[:nombre])
    data
  end

  def self.consult
    data = {}
    #data[:runProfesional] = Faker::Number.number(9)
    #data[:runPaciente] = Faker::Number.number(9)
    data[:idPaciente] = 1
    data[:idProfesional] =  1
    data[:fecha] = Faker::Date.backward
    data[:razon] = Faker::Company.name
    data[:sintoma] = Faker::Company.name
    data[:observaciones] = Faker::Company.name
    data
  end

  def self.read_file(file_name)
    file = File.open(file_name)
    data = file.read
    file.close
    data
  end

  def self.movement
    data = {}
    movements = %w[Exam Prescription Diagnostic License Procedure Other]
    data[:tipo] = movements[rand(0..5)]
    #data[:runProfesional] = Faker::Number.number(9)
    #data[:runPaciente] = Faker::Number.number(9)
    data[:consulta] = 1
    data[:detalles] = { 'other' => Faker::Lorem.paragraph(2, false, 20),
                        'files' => [{ 'name' => 'test.txt',
                                      'file' => Base64.encode64(read_file('test.jpg'))}]}
    data
  end

  
end

