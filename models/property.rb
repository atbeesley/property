require('pg')

class Property

  attr_accessor :id, :address, :value, :number_of_bedrooms, :year_built

  def initialize( options )
    @id = options['id'].to_i() if options['id']
    @address = options['address']
    @value = options['value']
    @number_of_bedrooms = options['number_of_bedrooms']
    @year_built = options['year_built']

  end

  def save()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
    sql =
    "INSERT INTO properties
    (
      address,
      value,
      number_of_bedrooms,
      year_built
      ) VALUES ($1, $2, $3, $4) RETURNING *"
      values = [@address, @value, @number_of_bedrooms, @year_built]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i()
      db.close()
    end

      def update()
          db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
          sql =
          "UPDATE properties SET
          (
            address,
            value,
            number_of_bedrooms,
            year_built
            ) = ($1, $2, $3, $4) WHERE id = $5"
            values = [@address, @value, @number_of_bedrooms, @year_built, @id]
            db.prepare("update, sql")
            db.exec_prepared("update", values)
            db.close()
          end


          def delete()
            db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
            sql = "DELETE FROM properties WHERE id = $1"
            values = [@id]
            db.prepare("delete_one", sql)
            db.exec_prepared("delete_one", values)
            db.close()
          end

          def Property.find(id)
            db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
            sql = "SELECT * FROM properties WHERE id = $1"
            values = [id]
            db.prepare("find", sql)
            property = db.exec_prepared("find", values)
            db.close()
            return Property.new(property[0])
          end

          def Property.find_by_address(address)
            db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
            sql = "SELECT * FROM properties WHERE address = $1"
            values = [address]
            db.prepare("find", sql)
            property = db.exec_prepared("find", values)
            db.close()
            return Property.new(property[0])
          end

          def Property.all()
            db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
            sql = "SELECT * FROM properties"
            db.prepare("all", sql)
            properties = db.exec_prepared("all")
            db.close()
            return properties.map {|property| Property.new(property)}
          end


      end
