module Palmade::DbEssentials
  module Exts

    # Allows anyone to use the map_polymorphic_type extension, to explicitly
    # map specific value types to specific classes. This can be useful, when
    # moving classes (changing namespace scope) and you still want to maintain
    # backward compatibility of data.
    module MapPolymorphicType
      class BelongsToPolymorphicAssociation < ::ActiveRecord::Associations::BelongsToPolymorphicAssociation

        # This part overrides the association_class method, to check if there's
        # an existing mapping for this type. If there is, then use that mapping
        # to constantize the value. Otherwise, just call the original method.
        def association_class
          poly_value = @owner[@reflection.options[:foreign_type]]
          unless poly_value.nil?
            owner_class = @owner.class
            r_name = @reflection.name.to_sym

            ptm = owner_class.read_inheritable_attribute(:polymorphic_type_map)
            unless ptm.nil?
              if ptm.include?(r_name) && ptm[r_name].include?(poly_value)
                ptm[r_name][poly_value].constantize
              else
                super
              end
            else
              super
            end
          else
            super
          end
        end
      end
      BTPA = BelongsToPolymorphicAssociation

      class HasManyAssociation < ::ActiveRecord::Associations::HasManyAssociation

        # Override the default construct_sql method, so we can check if this
        # polymorphic association has a specific map table. We'll use the explicit
        # map of types in the finder (aka WHERE) SQL statement.
        def construct_sql
          case
          when @reflection.options[:finder_sql]
            super
          when @reflection.options[:as]
            owner_class = @owner.class
            r_name = @reflection.name.to_sym

            ptm = owner_class.read_inheritable_attribute(:polymorphic_type_map)
            unless ptm.nil?
              if ptm.include?(r_name)
                types = ptm[r_name]

                @finder_sql = "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_id = #{owner_quoted_id} AND "
                if types.size > 1
                  @finder_sql << "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_type IN (#{types.collect { |t| quote_value(t) }.join(', ')})"
                else
                  @finder_sql << "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_type = #{quote_value(types.first)}"
                end
                @finder_sql << " AND (#{conditions})" if conditions

                if @reflection.options[:counter_sql]
                  @counter_sql = interpolate_sql(@reflection.options[:counter_sql])
                else
                  @counter_sql = @finder_sql
                end
              else
                super
              end
            else
              super
            end
          else
            super
          end
        end
      end
      HMA = HasManyAssociation

      module ClassMethods
        def map_polymorphic_type(association_id, *args)
          r = reflections[association_id]

          ptm = read_inheritable_attribute(:polymorphic_type_map)
          if ptm.nil?
            ptm = { }
            write_inheritable_attribute(:polymorphic_type_map, ptm)
          end

          case r.macro
          when :has_many
            ptm[association_id] ||= [ self.base_class.name.to_s ]
            ptm[association_id].concat(args)
            ptm[association_id].uniq!
          when :belongs_to
            ptm[association_id] ||= { }
            ptm[association_id].merge!(args.last)
          else
            raise "Unsupported polymorphic map association type #{r.macro}"
          end

          ptm[association_id]
        end

        def belongs_to_with_map_polymorphic_type(association_id, options = { })
          ret = belongs_to_without_map_polymorphic_type(association_id, options)

          r = reflections[association_id]
          if r.options[:polymorphic]
            # let's redefine the association, accesor methods to use our own inherited association proxy
            association_accessor_methods(r, BTPA)
          end

          ret
        end

        def has_many_with_map_polymorphic_type(association_id, options = { })
          ret = has_many_without_map_polymorphic_type(association_id, options)

          r = reflections[association_id]
          if r.options[:as]
            # let's redefine the association, accesor methods to use our own inherited association proxy
            collection_accessor_methods(r, HMA)
          end

          ret
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
        class << base
          alias_method_chain :belongs_to, :map_polymorphic_type
          alias_method_chain :has_many, :map_polymorphic_type
        end
      end
    end
  end
end
