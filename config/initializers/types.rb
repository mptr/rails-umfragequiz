class JsonListType < ActiveRecord::Type::Value
    def serialize(value)
        ActiveSupport::JSON.encode(value) unless value.nil?
    end
    def deserialize(value)
        return value unless value.is_a?(::String)
        ActiveSupport::JSON.decode(value) rescue []
    end
    def changed_in_place?(raw_old_value, new_value)
        raw_old_value != serialize(new_value)
    end
end
# https://github.com/rails/rails/blob/984c3ef2775781d47efa9f541ce570daa2434a80/activerecord/lib/active_record/type/json.rb#L25

ActiveRecord::Type.register(:json_list, JsonListType)
