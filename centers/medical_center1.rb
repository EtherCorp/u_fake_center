# frozen_string_literal: true

require 'faker'
require 'json'

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
    data[:runProfesional] = Faker::Number.number(9)
    data[:runPaciente] = Faker::Number.number(9)
    data[:fecha] = Faker::Date.backward
    data[:razon] = Faker::Company.name
    data[:sintoma] = Faker::Company.name
    data[:observaciones] = Faker::Company.name
    data
  end

  def self.movement
    data = {}
    movements = %w[Exam Prescription Diagnostic License Procedure Other]
    data[:tipo] = movements[rand(0..5)]
    data[:runProfesional] = Faker::Number.number(9)
    data[:runPaciente] = Faker::Number.number(9)
    data[:detalles] = ['detalle1 : detalle1', 'detalle2 : detalle2']
    data
  end
end
 
