class Hash
  def permit(*filters)
    res = {}
    filters.flatten.each do |filter|
      case filter
      when Symbol, String
        res[filter] = self[filter] if self.keys.include?(filter)
      when Hash then
        key = filter.keys.first
        res[key] = self[key].permit(filter[key]) if self.keys.include?(key)
      end
    end
    res
  end
end
