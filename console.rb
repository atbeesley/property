require('pry')
require_relative('models/property.rb')

property1 = Property.new({
  'address' => '37 Castle Street',
  'value' => '1000000',
  'number_of_bedrooms' => '4',
  'year_built' => '1976'
  })

property1.save()


property2 = Property.new({
  'address' => '28 Oak Terrace',
  'value' => '150000',
  'number_of_bedrooms' => '3',
  'year_built' => '1895'
  })

property2.save()

properties = Property.all()

binding.pry
nil
