module Palmade::DbEssentials
  module Helpers
    def self.use(helper_name, *args)
      mod = const_get(helper_name)
      if args.size > 0
        mod.setup(*args)
      else
        mod
      end
    end

    autoload :ActiveRecord2Helper, File.join(DB_ESSENTIALS_LIB_DIR, 'db_essentials/helpers/active_record2_helper')
  end
end
