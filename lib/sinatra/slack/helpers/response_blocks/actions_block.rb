module ResponseBlocks
  class ActionsBlock < Block
    self.type = "actions"

    attr_reader :elements
    serialize_attributes :elements

    def element(element_type, &block)
      element = Object.const_get(element_type)
      yield element if block_given?

      @elements ||= []
      @elements << element
    end
  end
end